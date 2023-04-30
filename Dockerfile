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
ARG TEST_GIT_USERNAME="John Doe"
ARG TEST_GIT_EMAIL="johndoe@example.com"
ARG TEST_GIT_COMMIT_MESSAGE="Initial commit"

RUN mkdir test && \
    cd test && \
    git init && \
    touch dummy.txt && \
    ../../entrypoint-test.sh "${TEST_GIT_USERNAME}" "${TEST_GIT_EMAIL}" "${TEST_GIT_COMMIT_MESSAGE}" && \
    git log -1 | grep "${TEST_GIT_COMMIT_MESSAGE}" && \
    cd .. && \
    rm -rf test

# Run the entrypoint script with the specified arguments
ENTRYPOINT ["/entrypoint.sh"]