FROM alpine:latest

# Install dependencies
RUN apk --no-cache add ca-certificates tzdata shadow su-exec

# Set the working directory
WORKDIR /listmonk

# Copy only the necessary files
COPY listmonk .
RUN chmod +x listmonk
COPY config.toml.sample config.toml

# Copy the entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Create uploads directory (needed at runtime)
RUN mkdir -p /listmonk/uploads

# Expose the application port
EXPOSE 8080

# Define the command to run the application
CMD ["sh", "-c", "echo ==== ENVIRONMENT ==== && env && echo ==== STARTING ==== && ./listmonk"]

