# Single Video PWA

This is designed to do only one thing: play the most recent video in a limited-interaction PWA.

An eldery lady in our community had become mostly shut-in, and wanted to be able to view her church service online. Although the church was streaming live to Facebook, and her family bought her a tablet, she had a number of challenges. Facebook's UI was confusing and kept changing, the tap targets were too small, and her hands were getting shaky, so she would end up with inadvertent interactions (dragging or long-pressing instead of the intended tap).

To help her, we installed Nova Launcher, hid unused icons, and made remaining ones as large as possible. Android's accessibility settings also allow adjustment of tap time. Facebook, however, could not be configured to be anything less than hostile for the eldery. In its place, a script uploads the completed video at the end of the service (with a consistent filename) and this PWA is the sole icon on her launcher. 

When launched (or re-launched), the PWA determines if its been at least 12 hours since it was last visible (sometimes she falls asleep, and needs to resume watching the video hours later). If less than 12 hours, it resumes. If more than 12 hours, it reloads, where a little cache-busting ensures the video is refreshed. Because Chrome will autoplay videos in an installed PWA, its literally a single tap, and she can watch the video.

I've generalized it a little, since this can be used for any periodically updated video. To use, you'll need to provide your own icons and video.
