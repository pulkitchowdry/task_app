# task_app
This app helps in managing tasks. This app has been built using Flutter and Back4App.

**How to Install Flutter**
Install using the link - https://docs.flutter.dev/get-started/install

Once installed, run the below command to check if there are any flutter dependencies to be installed,
flutter doctor

I performed the tests on Android and for this we can install Android studio where we can use the Emulator to test our application.
**How to Install Android Studio**
We can install Android studio using the link - https://developer.android.com/studio

**SignUp for Back4App**
We can signup for Back4App which will be our database for our application from the page - https://www.back4app.com/

**Setup of Back4App**
Click on Build new app in Back4App. Following is a screenshot for reference,

<img width="1076" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/ffb9431a-128a-4d51-84fe-f96b9f053deb">

Once the application is created. Click on create class in the top left corner,

<img width="307" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/b8ccba10-3626-4ff0-9453-677f2a42dd13">

Back4App is case-sensitive and so we need to have the Class name (This will be the Table name) and the field names in lowercase or any case which is preferred and can be used in the same manner in the code.

Click on Add column in the top left corner to add new fields in the task table,

<img width="1512" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/3f97f7a2-8bfd-4db4-82d0-8f0b5c84a7c6">

Select the data type as String for Title and Description while we can use the Date field type for Due date field. For the status field, I am using a Boolean field type where if the value is false then the task is Open while if the value is closed then it means that the taks is completed,

<img width="533" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/16b2e250-6c0f-4c8a-9cea-faff61793511">

Now, Back4App is setup for our application. Next we need to write the code in flutter for the application.

Open Visual Studio and install Flutter extension in it. 
Launch Visual Studio Code -> Open an empty folder
Open the command palette in VSCode (with F1 or Ctrl+Shift+P or Shift+Cmd+P). Type "flutter new". Select the Flutter: New Project command -> Create new Application and give it a name.
Flutter will automatically create the required set of files in the folder.

We will be editing two files mainly among all the files which have been created. 

In pubspec.yaml file, add the below dependencies,

  provider: ^6.1.1
  
  parse_server_sdk_flutter: ^7.0.0
  
  intl: ^0.17.0

Here we are adding these dependencies for Flutter SDK (dependency name - parse_server_sdk_flutter) and for Timezone (dependency name - intl) to be shown in the Due date field when a new task is being added.

Enter the code for the application in the main.dart file.

Following are screenshots of the application on how it works,

Initially when the application is opened, the title of the application is displayed in the top left corner "Task App".

We have 3 tabs for easier management of tasks. Open tasks tab displays all the tasks which are Open and yet to be completed. Completed tasks tab will display all the completed tasks. All tasks tab will display both the Open and Completed tasks.

Tasks are sorted based on the due date and time where the task which needs to be completed first based on the due date/time will be shown first.

We also have a plus icon shown in the bottom right corner to add new tasks.

Following is the first page of the application,

<img width="331" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/ccef10a6-0db9-4c77-af6f-e7fd33626535">

Clicking on the plus icon will display the Add task form where the user can enter Task Title, Description, Due Date and Time.

<img width="329" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/5ab88f4b-c8ee-488e-ab7f-8f9c22601fa2">

A calendar view and clock view is provided for selecting a date and time,

 <img width="326" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/af39b1c5-4ee2-4dac-8129-09a0dc384364">   <img width="324" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/96f362a2-0d2c-4e24-a53d-5570450ce4a4">

 <img width="334" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/5c2e0549-6d3d-4b7f-818d-f81f5a09464a">

 Once we add all the details and click on the Add task button then the new task will be added and shown in the Open tasks and All tasks tabs,

 <img width="338" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/9bca3dc9-87b7-464a-a357-0fe26f22201e">

 Following is a screenshot where we see that the tasks are sorted based on Date/time,
 
 <img width="328" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/27e15113-e165-49fc-b86d-e91277d2705d">

 We have provided two buttons for each task. One is to mark the task as completed while the other is to delete a task. Clicking on the Completed button will move the task to Completed status and will be displayed in the Completed tab in Green and with a check-mark showing that the task is complete,

 <img width="328" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/2e202d5d-997a-423f-ad5e-e46351a05d5e">  <img width="321" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/f5cbf1e0-ce6d-495e-92c5-496fbc2c516a">


 Clicking on the Delete icon will remove the task from the database.

 Following is how the tasks are shown in the database,

 <img width="1512" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/2c392626-1738-46aa-b914-7f090dc20be5">












