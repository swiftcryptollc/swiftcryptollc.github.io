---
layout: post
title:  "Add a Copy Button for Jekyll HTML Code"
date:   2021-11-11 15:00:00 -0500
---
So when I finally decided to create a website for my business, I started down the Angular path because that's what I knew.  It wasn't until I started playing with [Github Pages](https://pages.github.com/) that I was introduced to [Jekyll](https://jekyllrb.com/).  So far?  It's awesome.

All the memes about Full Stack Developers writing massive amounts of back end code in an hour or two, but then spending 6 hours trying to center a div are fairly accurate for me..  I've used CSS quite a bit, but I'll always stumble on something.  With Jekyll, a lot of that headache was taken away!  But one thing I wanted to be able to do, wasn't readily available in the theme I had chosen.  That was to have a "Copy" button on my code snippets.

Searching the internet, I came across a blog post from [Aleksandr Hovhannisyan](https://www.aleksandrhovhannisyan.com/blog/how-to-add-a-copy-to-clipboard-button-to-your-jekyll-blog/) (Thank you sir!).  I started implementing what he did but realized that I would have to make some changes to make it work for my site.

Here's what I did.

## Create a new JavaScript File ##

If you don't have a "js" directory in your base folder, add one.  Create a new file, add the following code to it, and save it.  I'm going to assume that you named the file "copyCode.js".  If you don't use [Font Awesome](https://fontawesome.com/), you will have to change the "fa-copy" and "fa-check" class references to your class.

{% include code_header.html %}
{% highlight javascript %}
const codeBlocks = document.querySelectorAll('figure > pre > code');
const copyCodeButtons = document.querySelectorAll('.copy-code-button');
copyCodeButtons.forEach((copyCodeButton, index) => {
  const code = codeBlocks[index].innerText;

  copyCodeButton.addEventListener('click', () => {
    window.navigator.clipboard.writeText(code);
    copyCodeButton.classList.remove('fa-copy');
    copyCodeButton.classList.add('fa-check');
 
    setTimeout(() => {
      copyCodeButton.classList.remove('fa-check');
      copyCodeButton.classList.add('fa-copy');
    }, 2000);
  });
});

{% endhighlight %}
<br />

## Add the Javascript File to an _include Template ##

I have a "js.html" file in my "_include" folder that contains all of the JavaScript to load for my site.  No matter how you add your JavaScript references, add your newly created file to the list.  For me, I added this line to my "js.html" file (rename the js file accordingly).

* Note that "defer" will cause the JavaScript to wait until the page loads before executing.  This is important since it'll look for code snippets, add listeners to each of the buttons, and properly map the button to it's code snippet.

{% include code_header.html %}
{% highlight javascript %}
<script src="{{ "/js/copyCode.js" | prepend: site.baseurl }}" defer></script>
{% endhighlight %}
<br />

## Add Copy Header HTML File ##

Create a new HTML file under "_include" that will contain the HTML to display the button.  I named mine "code_header.html".  Again, if you don't use [Font Awesome](https://fontawesome.com/), you will have to change the button class "fas fa-copy". 

{% include code_header.html %}
{% highlight html %}
<div class="code-header">
  <button class="copy-code-button fas fa-copy" aria-label="Copy code to clipboard"></button>
</div>
{% endhighlight %}
<br />


## Update Highlight References ##

Update any Highlight references you currently have and add a line immediately above it to include "code_header.html" (or whatever you named it). 

{% include code_header.html %}
{% highlight html %}
{% raw %}
{% include code_header.html %}
{% endraw %}
{% endhighlight %}
<br />

Full example:
{% include code_header.html %}
{% highlight rogue %}
{% raw %}
{% include code_header.html %}
{% highlight bash %}
echo "Hello";
{% endhighlight %}
{% endraw %}
{% endhighlight %}
<br />
## Add CSS ##

This part may unfortuntately need some modification for your site.  Create a new CSS file under "_includes/css" and paste the following into it.  

* You might need to change the "top" to properly align the button within your code snippet.  You also might need to change the "font-size" value so it looks appropriate for your site.  

{% include code_header.html %}
{% highlight html %}
.code-header {
    display: flex;
    justify-content: flex-end;
  }
  
.copy-code-button {
    display: grid;
    grid-auto-flow: column;
    align-items: center;
    grid-column-gap: 4px;
    cursor: pointer;
    font-size: 1rem;
    padding: 4px 8px;
    font-weight: 900;
    color: black;
    top: 20px !important;
    position: relative;
    border: none;
}
{% endhighlight %}
<br />

## Build and Deploy ##

Build and test your site out!

I realize this won't be just a copy/paste exercise for most of you, but hopefully this guide can get you 90% of the way there!  If you have any questions, please feel free to reach out!