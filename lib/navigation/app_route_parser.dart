import 'package:flutter/material.dart';

import 'app_link.dart';

class AppRouteParser extends RouteInformationParser<AppLink> {
// AppRouteParser extends RouteInformationParser. Notice it takes a generic
//type. In this case, your type is AppLink, which holds all the route and
//navigation information.

// About RouteInformationProvider:
//A delegate that is used by the [Router] widget to parse a route information
//into a configuration of type T.
//This delegate is used when the [Router] widget is first built with initial
//route information from [Router.routeInformationProvider] and any subsequent
//new route notifications from it. The [Router] widget calls the
//[parseRouteInformation] with the route information from
//[Router.routeInformationProvider].

  // The first method you need to override is parseRouteInformation(). The route
  //information contains the URL string.
  // For converting a URL to an app state:
  @override
  Future<AppLink> parseRouteInformation(
      RouteInformation routeInformation) async {
    //?? where is await??

    // Take the route information and build an instance of AppLink from it.
    final link = AppLink.fromLocation(routeInformation.location);
    /*
      ".location":
      The location of the application (in string form).
      The string is usually in the format of multiple string identifiers with  
    slashes in between. ex: /, /path, /path/to/the/app.
      It is equivalent to the URL in a web application.
    */
    return link;
  }

  // The second method you need to override is restoreRouteInformation().
  // For converting the app state to a URL string:
  @override
  RouteInformation restoreRouteInformation(AppLink appLink) {
    // This function passes in an AppLink object. You ask AppLink to give you
    //back the URL string.
    final location = appLink.toLocation();

    // You wrap it in RouteInformation to pass it along.
    return RouteInformation(location: location);
  }
}
