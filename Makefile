clean:
	-find -name "*.un~" -exec rm {} \;
	-find -name "*.swp" -exec rm {} \;
	-find -name "*.pyc" -exec rm {} \;

docker_container_remove:
	-docker stop $$(docker ps -a -q)
	-docker rm $$(docker ps -a -q)

docker_image_remove: docker_container_remove
	-docker rmi $$(docker images -q -f dangling=true)
	-docker rmi $$(docker images -q -f)


nvidia_docker_inastall:
	sh shell_script/nvidia-container-runtime-script.sh

nvidia_docker_test: 
	sudo docker run --gpus all nvidia/cuda:10.0-base nvidia-smi
