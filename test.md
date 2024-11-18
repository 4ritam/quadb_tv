Flutter Test

Design a Flutter App that consists of:
A splash screen
A Home screen
A Search screen
A details screen

Screen Details

Splash Screen:

The splash screen should contain a picture that you deem to be appropriate considering the theme of this assignment.

Home Screen:

This screen should show all the movies as returned by this API endpoint:
https://api.tvmaze.com/search/shows?q=all

Every movie’s design may be however you like but should clearly show the image as thumbnail, title and summary.

When clicked on any movie, it should go to the Details Screen.

Include a search bar at the top of the screen which redirects to the Search Screen when clicked.

Search Screen:

Includes a Search Bar which lets you search for any movie. The API endpoint to call in order to search is:


https://api.tvmaze.com/search/shows?q=${search_term}

Show the API’s response as you are showing in the Home Screen.

Details Screen:

This screen should show all the details of the particular movie clicked (image, summary, title, ....).

Some other information:

Your app should contain a bottom navigation to be able to navigate between the Home Screen and the Search Screen.
