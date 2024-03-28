# Use Alpine Linux as base image
FROM golang:alpine AS builder

# Install required packages
RUN apk add --no-cache git

# Install go binaries
RUN go install github.com/tomnomnom/assetfinder@latest
RUN go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
RUN go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest

# Build distroless image
FROM gcr.io/distroless/static-debian12

# Copy binaries from builder stage
COPY --from=builder /go/bin/assetfinder /usr/local/bin/
COPY --from=builder /go/bin/subfinder /usr/local/bin/
COPY --from=builder /go/bin/dnsx /usr/local/bin/

# Set the working directory
WORKDIR /usr/local/bin/

# Test commands
CMD ["assetfinder", “--subs-only”, "testla.com"]
CMD ["subfinder", “-d”,"testla.com"]
