### SEQUELIZE

-INSTALLATION
  - npm install --save sequelize
  - npm install --save-dev sequelize-cli

- MIGRATIONS
  
  - INITIALIZATION
    - command
      - npx sequelize-cli init -> it will create 4 folders
    - This will create following folders
      -  config, contains config file, which tells CLI how to connect with database
      -  models, contains all models for your project
      -  migrations, contains all migration files
      -  seeders, contains all seed files
    - Default mode is set to developement can be changed using .env - NODE_ENV
  
  - CREATING MODELS
    - command
      - npx sequelize-cli model:generate --name user --attributes firstName:string,lastName:string,email:string --underscored
    - Use model:generate command. This command requires two options:
      - name: the name of the model;
      - attributes: the list of model attributes
      - underscored: creates underscored column names
  
  - RUNNING MIGRATIONS
    - command
      - npx sequelize-cli db:migrate
      - npx sequelize-cli db:migrate --env=production (for production)
    - This command will execute these steps:
      - Will ensure a table called SequelizeMeta in database. This table is used to record which migrations have run on the current database
      - Start looking for any migration files which haven't run yet. This is possible by checking SequelizeMeta table. In this case it will run XXXXXXXXXXXXXX-create-user.js migration, which we created in last step.
      - Creates a table called Users with all columns as specified in its migration file.

  - UNDO MIGRATIONS
    - command (this command will only undo previous migration to undo all migration use :all after :undo)
      - npx sequelize-cli db:migrate:undo
    - Undo specifcy migration using following command
      - npx sequelize-cli db:migrate:undo:all --to XXXXXXXXXXXXXX-create-users.js

  - CHECK MIGRATION STATUS
    - command
      - npx sequelize-cli db:migrate:status

  - SEEDERS
    - command
      - npx sequelize-cli seed:generate --name fake-users
      - npx sequelize-cli db:seed:undo
      - npx sequelize-cli db:seed:undo:all
      - npx sequelize-cli db:seed --seed ./seeders/20230316094852-fake-contcats_info.js