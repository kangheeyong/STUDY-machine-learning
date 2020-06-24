clean:
	-find -name "*.un~" -exec rm {} \;
	-find -name "*.swp" -exec rm {} \;
	-find -name "*.pyc" -exec rm {} \;

run_jupyter_notebook:
	jupyter notebook --no-browser --NotebookApp.token= --ip=0.0.0.0 --port 8090 --allow-root 

