### Semantic-versioning
- https://docs.npmjs.com/about-semantic-versioning
- Patch releases: 1.0 or 1.0.x or ~1.0.4
- Minor releases: 1 or 1.x or ^1.0.4
- Major releases: * or x

### SSH
- Lear ssh commands
  - https://explainshell.com/
### Npm Login
```
npm login --scope=@nexsalesdev --registry=https://npm.pkg.github.com
```

### Grunt Bump
``` npx grunt bump:major/minor/patch ```

### Docker
- Bring Up Indivdual Service
  - ``` docker-compose up -d postgres ```
- Remove all Container and Images
  - ``` docker system prune -a ```
- Remove all Volumns
  - ``` docker volume prune ```
- Re-Run Docker System (GoldMine)
  - ``` ./bin/docker/compose-up.sh ```
- Stop all running container
  - ```docker stop $(docker ps -a -q)```


### List Service
``` sudo lsof -i -n -P | more ```

### Python
- Check version of Python  - ``` python --version``` 
- Install dependies
- **PYENV**
  - Reffrence Link - https://realpython.com/intro-to-pyenv/
  - Manage Python Version - ```pyenv```
    - List all installed python versions -- ```pyenv versions```
    - Latest version set by pyenv -- ```pyenv version```
    - List all python version available for instalation -- ```pyenv install -l```
    - Install a python version -- ```pyenv install <version_name>```
    - Uninstall a python version -- ```pyenv uninstall <version_name>```
    - Set a python version -- ```pyenv global <version_number>```
- **VENV**
  - Reffrence Link - https://docs.python.org/3/library/venv.html
  - Manage virtual environments in a projects -- ```venv```
    - Create virtual environment -- ```python3 -m venv /path/to/new/virtual/environment```
    - Activate your virtual envirnment (naviagte to) --  ```<vir_env>\bin\python```
- **Mini Conda**
  - Create Virtual envirnment -- ```conda create -p <path> python=<version>```
  - Activate virtual env -- ```conda activate/deactivate <path>```

### Restart Riak
  - Command to connect ```ssh -v -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o ProxyCommand="ssh -p 22854 -W %h:%p sukhdevkushwaha@bastion.rightleads.io" sukhdevkushwaha@10.0.7.24```
  - sudo su root <----------[switch to root user]
  - riak ping <---------------------[it should fail if riak is down]
  - systemctl restart riak <-----------[restart riak]
  - riak ping <----------------------[it should responde with pong!]
  - riak-admin cluster status <---------[display riak cluster status]

### Linux Space
  - df -H <------------------------------[Check for drive space]
  - du -sh * | sort -h <----------------[list folders with size]

### Git
  - Delete all branch expcept (dev|beta|prod) ```git branch | grep -v "dev" | grep -v "beta" | grep -v "prod" | xargs git branch -D```

### GCP Bucket Corss Update
  - Fetch policy ```gcloud storage buckets describe gs://market-sizing-prod --format="default(cors_config)"```
  - Set plicy ```gcloud storage buckets update gs://market-sizing-prod --cors-file=./gcp-bucket-acess.json```

### Some CMD Commands
  - deleted nested folder ```find . -name node_modules -type d -exec rm -rf {} \;```
  - for file ```find . -type f -name package-lock.json -delete``` 
  - 

### Update Bucket CORS Policy
  - Document Link - https://cloud.google.com/storage/docs/gsutil/commands/cors
  - Get CORS Policy ```gsutil cors get gs://Bucket_Name```
  - Set CORS Policy ```gsutil cors set ACESS_JSON_FILE gs://BUCKET_NAME```
  - ACESS_JSON_FILE - Reffer to file ```gcp-bucket-acess.json```