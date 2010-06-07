    Lebowski Framework
  
    -- the SproutCore feature and integration test automation framework

#Overview

The Lebowski framework is a test automation framework for applications built on the 
[SproutCore](http://www.sproutcore.com/) framework. 

Compared to unit testing frameworks that are perfect for testing individual objects
and functions, Lebowski is an automated test framework designed for full 
feature, integration, and regression testing of an application. 

The framework was created with the following in mind:

  * Provide a way for those who write feature and integration tests to build scripts 
    that reflect how the application was build using the SproutCore framework and
    abstract away from all the low-level HTML and JavaScript.

  * Allow you to easily access any SproutCore objects that make up your application
    
  * Allow you to perform all the common user actions and will address all the subtle 
    ways to correctly interact with the views that make up your application
    
  * Make it easy to add extensions so that you can work with custom views you've
    built for your application.

The Lebowski framework was built using the [Ruby](http://www.ruby-lang.org/en/) programming language. 
Therefore, to use this framework you will have to know some basic Ruby in order to get started. 
In addition, the framework also make use of [Selenium](http://seleniumhq.org/) remote control server 
in order to open up a browser, load your SproutCore application, and communicate with the application. 
Knowledge of selenium server is not required to use the framework. (Note that the selenium server is
dependent on your system having the latest Java runtime installed). 

The framework also comes with extensions to [RSpec](http://rspec.info/) that you can optionally use to 
write your scripts, but RSpec is not required to use the Lebowski framework. 

#Installing Lebowski

Installing the Lebowski framework is simple. First, make sure that you have the latest Ruby installed 
on your machine (version 1.9+). Once you have Ruby installed, you can get the Lebowski framework
by invoking the following from your terminal:

    $ gem install lebowski
    
Depending on the setup of your system you may have to call `gem1.9` and use the `sudo` command. 

If everything worked out you should have the lebowski gem installed on your computer. The framework is
dependent on two gems:

  * selenium-client 1.2.18
  * rspec 1.3.0

For RSpec, it is only required if you plan on using the Lebowski's RSpec extensions.

Once installed you will have three executables installed that you can use to run your
Lebowski scripts:

  * `lebowski-start-server` - Starts the selenium server
  * `lebowski` - Can be used to run your Ruby scripts that use Lebowski
  * `lebowski-spec` - Can be used to run your spec tests that use Lebowski

Of the three listed above, the one that must always be executed before executing a script
using Lebowski is the `lebowski-start-server`.

It is assumed that you have the SproutCore framework installed on your machine, but if not,
you can grab the framework by doing the following:

    $ gem install sproutcore
    
At this time, the Lebowski framework works with SproutCore v1.0.1046.

In addition to SproutCore, it is also advised that you, at minimum, have [Firefox](http://www.mozilla.com/en-US/firefox/personal.html) 
installed on your system since that is the default browser used to run your SproutCore application using
Lebowski.

#Getting Started With Lebowski

If you're new to the Lebowski framework then the best place to get started is to try
and run the Hello World example that you can find in the `examples/hello_world` directory when
you clone the Lebowski framework from github. In the directory you'll see two sub-directories: 
app and spec. The app directory contains the Hello World SproutCore application. The spec folder 
contains three files that will test the application using the Lebowski framework. 

To get started, you'll first need to start the selenium server using `lebowski-start-server`. 
Next, you will need to start up the hello world example app using `sc-server` within the app 
directory. Check that you can see the application by opening a browser and going to the 
following URL:

    http://localhost:4020/hello_world
  
If the app started correctly you should see a label with the text "Click a button", and
two buttons below the label with titles "Hello" and "World". If you click the two buttons
you should see the label's caption change between "Hello" and "World". 

You can see how the views were added to the application by looking at the `main_page.js` file 
in the `app/apps/hello_world/resources` folder. 

With the application started, you can start by running the first hello world spec file
like so:

    $ cd examples/hello_world/spec
    $ lebowski-spec -f n hello_world_spec.rb
  
If everything worked you should see the following outputted your terminal:

    Hello World Test
      will check that label has an initial value 'click a button'
      will check that hello button has title 'hello'
      will check that world button has title 'world'
      will click hello button and then confirm label has value 'hello'
      will click world button and then confirm label has value 'world'

    Finished in 1.810166 seconds

    5 examples, 0 failures

If you got output that looks like the output above then congratulations, you've just run 
your first Lebowski script. For a slightly more complicated script, try running the
`hello_world_2_spec.rb` file. 

If you examine the hello world spec files, you'll see that they introduce to
some of the main concepts of using the Lebowski framework, namely:

  * Starting up the application
  * Defining paths
  * Accessing views by relative property paths and identifiers
  * Accessing a view's properties
  * Using the Lebowski RSpec extensions
  * Creating a custom path proxy  

After you get yourself familiar with the hello world example app, you can move on and learn
how to make a custom type proxy by going to the `custom_view` example app. 

If you like to know what proxies the Lebowski framework comes with and know how to use them, 
be sure to check out the `sc_controls` example app.

#Why the name "Lebowski"?

> sometimes there's a man... I won't say a hero, 'cause, what's a hero? But sometimes, 
> there's a man. And I'm talkin' about the [Dude](http://www.imdb.com/title/tt0118715/) here. 
> Sometimes, there's a man, well, he's the man for his time and place. He fits right in there. 
> And that's the Dude, in Los Angeles. And even if he's a lazy man - and the Dude was most certainly 
> that. Quite possibly the laziest in Los Angeles County, which would place him high in the runnin' 
> for laziest worldwide. But sometimes there's a man, sometimes, there's a man.

