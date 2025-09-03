<img src="https://raw.githubusercontent.com/jujuadams/ScribbleJunior/master/LOGO.png" width="50%" style="display: block; margin: auto;" />
<h1 align="center">Scribble Junior 1.6</h1>
<p align="center">Lightweight text renderer for GameMaker 2024.11 by <a href="https://www.jujuadams.com/" target="_blank">Juju Adams</a></p>

<p align="center"><a href="https://github.com/jujuadams/ScribbleJunior/releases/" target="_blank">Download the .yymps</a></p>

&nbsp;

## Frequently Asked Questions

**What's the difference between Scribble Junior and [Scribble Deluxe](https://github.com/JujuAdams/Scribble/)?**

Scribble Junior is a stripped back lighter text rendering solution compared to Scribble Deluxe. The focus for Scribble Junior is static text that doesn't need to animate where performance is the primary concern. Scribble Deluxe is oriented towards complex text effects where there's a lot of animation and fancy effects going on.

&nbsp;

**Which function should I use?**

The decision primarily falls down to features. The first decision is whether you'd like to use in-line sprites and colours. The second decision is how you'd like text to respond to limited space. This is easiest to understand as a table:

|                         |Plain text        |In-line sprites and colours|
|-------------------------|------------------|---------------------------|
|**No layout**            |`Scribblejr`      |`ScribblejrExt`            |
|**Shrink without reflow**|`ScribblejrShrink`|`ScribblejrShrinkExt`      |
|**Fit-to-box**           |`ScribblejrFit`   |`ScribblejrFitExt`         |

&nbsp;

**Which function is the fastest?**

There are two kinds of performance to consider: up-front cost to parse text, and the on-going cost to render text.

The cost to parse text varies a lot depending on how much text you have; however, as a rule of thumb, `ScribblejrFit()` and `ScribblejrFitExt()` are the most expensive functions in general. `ScribblejrExt()` and `ScribblejrShrinkExt()` are more expensive than their plain text siblings.

The on-going cost is less for plain text and higher for text that contain in-line sprites. The difference is small but if you're looking for one, there is one.

Overall, `Scribblejr()` is the fastest and `ScribblejrFitExt()` is the slowest. If a function has more features, it'll operate slower. Try to use the right function for the job if you're concerned about performance - don't use `ScribblejrFitExt()` when `Scribblejr()` will do.

&nbsp;

**Can I use Scribble Junior alongside [Scribble Deluxe](https://github.com/JujuAdams/Scribble/)?**

Yes! In fact, I encourage it. Scribble Junior is excellent for static UI text whereas Scribble Deluxe is geared more towards dialogue and animated text.

&nbsp;

**What platforms does Scribble Junior support?**

Everything apart from HTML5. You might run into edge cases on platforms that I don't regularly test; please [report any bugs](https://github.com/JujuAdams/ScribbleJunior/issues) if and when you find them.

&nbsp;

**What versions of GameMaker does Scribble Junior support?**

Scribble Junior primarily supports GameMaker 2023.8, and in theory supports every version of GameMaker later than that. Later versions of GameMaker may change functionality in a way that Scribble Junior is not forwards-compatible with, but Scribble Junior uses only native GameMaker functions so is in the best possible position for long-term compatibility.

&nbsp;

**How is Scribble Junior licensed? Can I use it for commercial projects?**

[Scribble Junior is released under the MIT license](https://github.com/JujuAdams/ScribbleJunior/blob/master/LICENSE). This means you can use it for whatever purpose you want, including commercial projects. It'd mean a lot to me if you'd drop my name in your credits (Juju Adams) and/or say thanks, but you're under no obligation to do so.

&nbsp;

**I think you're missing a useful feature and I'd like you to implement it!**

Great! Please make a [feature request](https://github.com/JujuAdams/ScribbleJunior/issues). Feature requests make Scribble Junior a more fun tool to use and gives me something to think about when I'm bored on public transport.

&nbsp;

**I found a bug, and it both scares and mildly annoys me. What is the best way to get the problem solved?**

Please make a [bug report](https://github.com/JujuAdams/ScribbleJunior/issues). Juju checks GitHub every day and bug fixes usually go out a couple days after that.

&nbsp;

**Who made Scribble Junior?**

Scribble Junior is built and maintained by [@jujuadams](https://twitter.com/jujuadams) who has a long history of fiddling with text engines. Juju's worked on a lot of [commercial GameMaker games](http://www.jujuadams.com/).

&nbsp;

**Can I send you donations? Are you going to start a Patreon?**

Thank you for wanting to show your appreciation - it really does mean a lot to me personally - but I'm fortunate enough to have a stable income from gamedev. I'm not looking to join Patreon as a creator at this moment in time. If you'd like to support my work then drop me a credit in your game and/or gimme a shout-out on the social media platform of your choice.

&nbsp;

## Updating

Releases go out once in while, typically expedited if there is a serious bug. This library uses [semantic versioning](https://semver.org/). In short, if the left-most number in the version is increased then this is a "major version increase". Major version increases introduce breaking changes and you'll almost certainly have to rewrite some code. However, if the middle or right-most number in the version is increased then you probably won't have to rewrite any code. For example, moving from `1.1.0` to `2.0.0` is a major version increase but moving from `1.1.0` to `1.2.0` isn't.

?> Please always read patch notes. Very occasionally a minor breaking change in an obscure feature may be introduced by a minor version increase.

At any rate, the process to update is as follows:

1. **Back up your whole project using source control!**
2. Back up the contents of your configuration script (`__ScribblejrConfig`) within your project. Duplicating the script is sufficient
3. Delete all library scripts from your project. Unless you've moved things around, this means deleting the library folder from the asset browser
4. Import the latest [.yymps](https://github.com/JujuAdams/ScribbleJunior/releases/)
5. Restore your configuration script from the back-up line by line

!> Because configuration macros might be added or removed between versions, it's important to restore your configuration script carefully.
