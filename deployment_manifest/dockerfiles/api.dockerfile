# Use an official Node.js runtime as a parent image
FROM node:20-alpine



# Set the working directory to /app
WORKDIR /app
COPY . /app

# Install the dependencies
RUN npm install

# Build the application
RUN npm run build

# Expose port 9000 for the server
EXPOSE 9000

# Start the server with the environment variable DOTENV_KEY
CMD ["sh", "-c", "node --unhandled-rejections=warn dist/main.js"]
