clean:
	-find -name "*.un~" -exec rm {} \;
	-find -name "*.swp" -exec rm {} \;
	-find -name "*.pyc" -exec rm {} \;


process_run: make_folder
	supervisord -c /home/STUDY-machine-learning/supervisor/basic_process.conf

process_monitor:
	supervisorctl -s http://localhost:23231

make_folder:
	-mkdir ~/log

get_requirements:
	pip3 freeze > requirements.txt

docker_container_remove:
	-sudo docker stop $$(sudo docker ps -a -q -f name=jeiger-gpu)
	-sudo docker rm $$(sudo docker ps -a -q -f name=jeiger-gpu)

docker_image_remove: docker_container_remove
	-sudo docker rmi $$(sudo docker images -q -f dangling=true)
	-sudo docker rmi $$(docker images -q -f reference=local/cuda:10.0-base)
	
docker_run:
	sudo docker build -t local/cuda:10.0-base -f docker/Dockerfile .
	sudo docker run --gpus all -d -ti -p 8090:8090 --name jeiger-gpu local/cuda:10.0-base

docker_exec:
	sudo docker exec -ti jeiger-gpu /bin/zsh --login

nvidia_docker_inastall:
	sh shell_script/nvidia-container-runtime-script.sh

nvidia_docker_test: 
	sudo docker run --gpus all nvidia/cuda:10.0-base nvidia-smi
