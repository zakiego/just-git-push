# Set the base image
FROM alpine:3.14

# Install git and bash
RUN apk add --no-cache git bash

# Set the working directory
WORKDIR /workdir

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh

# Make the script executable
RUN chmod +x /entrypoint.sh

# Run the entrypoint script with the specified arguments
ENTRYPOINT ["/entrypoint.sh"]