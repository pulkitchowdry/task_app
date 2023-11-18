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

<img width="1077" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/999dc251-293e-48df-8b63-79dcdcb95928">


Once the application is created. Click on create class in the top left corner,

<img width="302" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/41107064-cf35-4c12-a487-b42cae364f73">


Back4App is case-sensitive and so we need to have the Class name (This will be the Table name) and the field names in lowercase or any case which is preferred and can be used in the same manner in the code.

Click on Add column in the top left corner to add new fields in the task table,

<img width="1512" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/c9b6b3fb-1737-4989-a92a-37149a8af983">


Select the data type as String for Title and Description while we can use the Date field type for Due date field. For the status field, I am using a Boolean field type where if the value is false then the task is Open while if the value is closed then it means that the taks is completed,

<img width="534" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/f6d20f00-cf7a-41f2-be07-e6f0e9d58b63">


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

<img width="324" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/e24fc4ed-4f77-4f55-8f94-d76b98df1518">


Clicking on the plus icon will display the Add task form where the user can enter Task Title, Description, Due Date and Time.

<img width="326" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/c156a95a-f17a-4c5d-b119-d612c34d2236">

A calendar view and clock view is provided for selecting a date and time,

 <img width="309" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/6919e460-50f4-416d-b90a-7ce930dce07a">
   <img width="322" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/21b85d4c-5c93-4bfe-a0b1-5d8e08dbfd2d">


<img width="320" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/f2f2e3a4-a2ab-402a-ba18-877c2e1770d8">

 Once we add all the details and click on the Add task button then the new task will be added and shown in the Open tasks and All tasks tabs. The tasks will be ordered based on Due date/time,

<img width="324" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/168b7993-7729-455f-ae65-821a897b33a6">


 We have provided two buttons for each task. One is to mark the task as completed while the other is to delete a task. Clicking on the Completed button will move the task to Completed status and will be displayed in the Completed tab in Green and with a check-mark showing that the task is complete,

<img width="320" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/99c741c4-0923-4b11-b3f5-a12d6b35473c">


All Tasks page where both Open and Completed tasks are shown and sorted based on Due date/time,

<img width="321" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/cc195ded-0b58-4214-b119-63bb6732330b">


 Clicking on the Delete icon will remove the task from the database.

 Following is how the tasks are shown in the database,

<img width="1512" alt="image" src="https://github.com/pulkitchowdry/task_app/assets/137600635/f4f339f1-2e3c-45c6-beef-57b39201a0c8">













