#!/bin/bash

# Build command string
GRAB_CMD="npm run grab -- --site ${SITE} --maxConnections ${MAX_CONNECTIONS} --days ${DAYS}"
if [ -n "${LANG}" ] && [ "${LANG}" != "all" ]; then
    GRAB_CMD="${GRAB_CMD} --lang ${LANG}"
fi

# Initial grab
echo "Running initial grab..."
eval "${GRAB_CMD}"

# Create a script to run periodically
echo "Creating /epg-grabber.sh..."
cat <<EOF > /epg-grabber.sh
#!/bin/bash
echo "[CRON] Running grab at \$(date)"
${GRAB_CMD}
EOF
chmod +x /epg-grabber.sh

# Setup PM2 with cron restart
echo "Setting up scheduled grabs with PM2..."
cat <<EOF > ecosystem.config.js
module.exports = {
  apps: [
    {
      name: "epg-grabber",
      script: "/epg-grabber.sh",
      cron_restart: "${CRON}",
      autorestart: false
    }
  ]
}
EOF

# Start PM2 with ecosystem file
pm2 start ecosystem.config.js

# Keep PM2 running + show logs
pm2 logs --timestamp
