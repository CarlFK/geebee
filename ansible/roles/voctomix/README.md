# voctomix

Manage and configure the voctomix live editing software.

sequence:

Boot:
voctocore
voctocore-cmds.py - set core to PnP (this isn't happening)
videoteam-record-timestamp-ts/mp4 - start saving whatever to disk.
cutlist.service - if something tells core to cut, log it.

As hardware is detected/available:
hardware:
  camera, usb mic
  hdmi video, hdmi audio

ingest.py (s)
each ingest is a pair of A/V, probably should not launch until both up?

Hmm... camera can be static, like on orangePi /dev/v4l/by-path/platform-rkisp1-vir1-video-index0
OrangePi /etc/udev/rules.d/88-rockchip-camera.rules
ACTION=="add", SUBSYSTEM=="video4linux", ENV{ID_V4L_PRODUCT}=="*_mainpath", SYMLINK+="video-camera0"
so ...

which is paired up with usb mic alsa name: device=hw:GoMic

grabber is usb video and audio. audio alsa name: device=hw:W30

When gui is available (login?):
sink-display.sh - show the mixed streams.  or black if they have not started.

When a thumbdrive is plugged in: (later.  Lets get recordings working first)
videoteam-copy-recordings.sh

audio device names:

pi@pi:~ $ arecord -l
**** List of CAPTURE Hardware Devices ****
card 2: GoMic [Samson GoMic], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 3: W30 [WARRKY USB 3.0], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

alsasrc device=hw:GoMic
alsasrc device=hw:W30

## Tasks

The tasks are divided this way:

* `tasks/scripts.yml`: Manage useful scripts for the video director.

* `tasks/voctomix.yml`: Install and configure voctomix.

* `tasks/sources.yml`: Manage ingest sources

## Available variables

Main variables are:

* `user_name`: Main user username.

* `org`: Name of your organisation. Used in video files path.

* `show`: Name of the event. Used in the video files path.

* `room_name`: Name of the room where you are recording. Used in the video file
               path.

* `frequency`: The local frequency setting (50 or 60Hz). Used to derive
               sensible defaults.

* `voctomix.framerate`: Integer. Number of frames per second to record at.
                        Defaults to `frequency/2`

* `voctomix.previews`: Boolean. Generate (and use) down-sampled preview
                       streams, for the GUI.

* `voctomix.mirrors`: Boolean. Mirror video sources on the 1300X TCP port
                      range, for vogol.

* `voctomix.recordings_port`: Optional. Voctocore port to stream recordings to.

* `recording_format`: `mpeg2` (more IO, less CPU) or `h.264` (more CPU, less IO) gst-oc (gstreamer.)

* `recording_timezone`: Optional. Record timestamps in the specified TZ.

* `ingest_sources.*`: Array of sources serviced by outcasts-ingest.

* `ingest_sources.description`: Human readable clue, used as the systemd
  service description.

* `ingest_sources.name`: Human readable word, Voctogui lable.

* `ingest_sources.src`: All of the source elements of a gst pipeline. More
  flexable but more cumbersome than having ingest construct the string. If
  specified, the audio and video options below are ignored.

* `ingest_sources.video_source`: The family of video device,
  or the video source elements of a gst pipeline.  Middle flexable/cumbersome.
  passed to `--video-source.`

* `ingest_sources.video_attribs`: gst attributes of the source element.

* `ingest_sources.video_delay`: Delay in ms for the video capture.

* `ingest_sources.video_elements`: Video transformation elements.

* `ingest_sources.audio_source`: The family of audio device, or audio pipeline.

* `ingest_sources.audio_attribs`: gst attributes of the source element.

* `ingest_sources.audio_delay`: Delay in ms for the audio capture.

* `ingest_sources.audio_elements`: Audio transformation elements.

* `ingest_sources.port`: Voctocore port to send to.

* `rsync_excludes`: List. Paths to exclude during the rsync copy of the video
                    files.

* `rsync_sshopts`: Rsync SSH options.

* `video_disk`: Partition to create and mount on `/srv/video`.

* `audiosource`: Name of the source that has audio. Undefined by default since
                 voctomix attributes this to the first camera by default.

Other variables used are:

* `skip_unit_test`:  Used internally by the test suite to disable actions that
                     can't be performed in the gitlab-ci test runner.
