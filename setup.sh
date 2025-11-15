#!/bin/bash

# Z Voice Switch - Automated Setup Script
# This script creates the complete project structure

echo "Setting up Z Voice Switch project..."

# Create directory structure
mkdir -p src/modules
mkdir -p src/config
mkdir -p database
mkdir -p logs

echo "Creating configuration files..."

# Create .env file
cat > .env << 'EOF'
PORT=3000
NODE_ENV=production
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=voip
REDIS_URL=redis://localhost:6379
DINSTAR_IP=192.168.1.100
DINSTAR_PORT=8000
DINSTAR_USER=admin
DINSTAR_PASS=admin
SIP_PORT=5060
SIP_HOST=0.0.0.0
EOF

echo "Installing dependencies..."
npm install

echo "Creating database schema..."
mysql -u root -p < database/schema.sql

echo "\n===================="
echo "Setup Complete!"
echo "===================="
echo "\nNext steps:"
echo "1. Update .env with your configuration"
echo "2. Run 'npm start' to start the server"
echo "3. Access API at http://localhost:3000"
echo "\nFor development: npm run dev"
