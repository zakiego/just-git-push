# Set the base image
FROM alpine:3.14

# Install git and bash
RUN apk add --no-cache git bash

# Set the working directory
WORKDIR /workdir

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
COPY entrypoint-test.sh /entrypoint-test.sh

# Make the script executable
RUN chmod +x /entrypoint.sh
RUN chmod +x /entrypoint-test.sh

# Create a test folder and initialize a git repository

ENV username="John Doe"
ENV email="johndoe@example.com"
ENV commit_message="Initial commit"

RUN mkdir test && \
    cd test && \
    git init && \
    touch dummy.txt && \
    ../../entrypoint-test.sh && \
    git log -1 | grep "${commit_message}" && \
    cd .. && \
    rm -rf test

# Run the entrypoint script with the specified arguments
ENTRYPOINT ["/entrypoint.sh"]