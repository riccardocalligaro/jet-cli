# jet-cli

<p align="center">
  <img src="https://i.imgur.com/YEq82GN.png">
</p>


Throughout the life span of a project, when we build new features, we often need to add new resources to our application. These resources typically require multiple, repetitive operations that we have to repeat each time we define a new resource.

## Commands

### `$ jet g project`

Create base project in seconds with a lot of useful stuff.


```
jet g project new_application

> Enter a 2 letter code that will identify your app (NA for example): 
> Enter the package name: 

Project
> ? Would you like to use all three levels (data/domain/presentation)?
> ? Would you like to use functional programming for error handling?
> ? Would you like to have localization?

Infrastructure
> ? Would you like to use firebase for production logging?

Data layer
> ? Would you like to have a local datasource (sqlite database)?
> ? Would you like to have a remote datasource (dio client)?

Presentation layer
> ? Would you like to have some generic widgets?

```



### `$ jet g feature`


```
jet g feature feature_name

> ? Does this feature have a data layer?
    > ? Does this feature have a remote datasource?
        > Enter the name of the object model:
        > ? Is the return type a list?
        > Enter the object JSON response: 
        > Enter the api call path:
        > ? Do you want the call in the repository?

    > ? Does this feature have a local datasource?
        > Enter the name of the object model:
        > ? Do you want the call in the repository?
            > ? Stream or future?
        
> ? Does this feature have a domain layer?
    > ? Do you want to create an object with the same charateristichs as the remote one?
    > ? Do you want Use Cases?

> ? Does this feature have a presentation layer?
    > ? Do you want to generate a Bloc for the remote datasource?
        > Enter the bloc name:
    > ? Do you want to generate a Bloc for the local datasource?
        > Enter the bloc name:

    > Do you want to generate a page with the bloc consumer?

[1] Barcode scanner
[2] Calendar
...
> ? Would you like to implement any of these features?
```
