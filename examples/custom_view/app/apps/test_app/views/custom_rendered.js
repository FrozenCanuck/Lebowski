// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.CustomRenderedView = SC.View.extend({

  classNames: 'custom-rendered-view'.w(),

  render: function(context, firstTime) {

    context = context.begin().addClass('main-box1');
    
    context = context.begin('a')
                .addClass('larry stooges')
                .attr('href', 'http://larry.com')
                .text('Larry')
              .end();
    
    context = context.begin('a')
                .addClass('curly stooges')
                .attr('href', 'http://curly.org')
                .text('Curly')
              .end();
    
    context = context.begin('a')
                .addClass('moe stooges')
                .attr('href', 'http://moe.net')
                .text('Moe')
              .end();
    
    context = context.end(); // main-box1
    
    context = context.begin().addClass('main-box2');
    context = context.begin('p').text('hello world').end();
    context = context.end(); // main-box2
    
    context = context.begin().addClass('main-box3');
    
    context = context.begin('img')
                .addClass('alert sc-icon-alert-48')
                .attr('src', SC.BLANK_IMAGE_URL)
              .end();
    
    context = context.begin('img')
                .addClass('info sc-icon-info-48')
                .attr('src', SC.BLANK_IMAGE_URL)
              .end();
    
    context = context.end(); // main-box3
  },
  
  $mainBox1: function() { return this.$('.main-box1'); },
  
  $larryLink: function() { return this.$('.main-box1 a.larry'); },
  
  $curlyLink: function() { return this.$('.main-box1 a.curly'); },
  
  $moeLink: function() { return this.$('.main-box1 a.moe'); },
  
  $mainBox2: function() { return this.$('.main-box2'); },
  
  $helloWorldParagraph: function() { return this.$('.main-box2 p'); },
  
  $mainBox3: function() { return this.$('.main-box3'); },
  
  $alertImage: function() { return this.$('.main-box3 img.alert'); },
  
  $infoImage: function() { return this.$('.main-box3 img.info'); },
  
  mouseDown: function(evt) {
    return true;
  },
  
  mouseUp: function(evt) {
    if (this.$helloWorldParagraph().within(evt.target)) {
     if (this.$mainBox2().hasClass('active')) {
       this.$mainBox2().removeClass('active');
     } else {
       this.$mainBox2().addClass('active');
     }
     return true;
    }
    
    return false;
  },
  
  doubleClick: function(evt) {
    if (this.$alertImage().within(evt.target)) {
      this.$mainBox3().addClass('black');
      this.$mainBox3().removeClass('white');
      return true;
    }
    else if (this.$infoImage().within(evt.target)) {
      this.$mainBox3().addClass('white');
      this.$mainBox3().removeClass('black');
      return true;
    }
    else if (this.$mainBox3().within(evt.target)) {
      this.$mainBox3().removeClass('black');
      this.$mainBox3().removeClass('white');
      return true;
    }
    
    return false;
  }

});
