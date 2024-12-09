#!/bin/bash

# Check if the container 'youtube-clone' is running
container_name="youtube-clone"
container_status=$(docker ps -q -f name=$container_name)

if [ -n "$container_status" ]; then
    # If the container is running, stop it
    echo "Container '$container_name' is running. Stopping it..."
    docker stop $container_status
    echo "Container '$container_name' stopped."
else
    # If the container is not running, check and remove the container if it exists
    echo "Container '$container_name' is not running. Checking for any stopped container..."
    stopped_container=$(docker ps -aq -f name=$container_name)

    if [ -n "$stopped_container" ]; then
        echo "Removing stopped container '$container_name'..."
        docker rm $stopped_container
        echo "Stopped container '$container_name' removed."
    else
        echo "No container named '$container_name' found."
    fi
fi

# Check if the image 'youtube-clone' exists and remove it
image_name="sr79979/youtube-clone"
image_exists=$(docker images -q $image_name)

if [ -n "$image_exists" ]; then
    echo "Image '$image_name' found. Removing it..."
    docker rmi $image_name
    echo "Image '$image_name' removed."
else
    echo "No image named '$image_name' found."
fi
