# Use an official Node.js runtime as a parent image
FROM node:23.9.0-alpine

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json first for efficient caching
COPY package*.json ./

# Install dependencies
RUN npm install --only=production

# Copy the rest of the application code
COPY . .

# Expose the application port
EXPOSE 3000

# Define the command to run the app
CMD ["node", "src/server.js"]
