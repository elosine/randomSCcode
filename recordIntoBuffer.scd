


(s.options.numInputBusChannels = 4;
s.waitForBoot{

	SynthDef(\recordIntoBuffer, {
		arg buf = 0;
		var src;
		src = SoundIn.ar(2);
		RecordBuf.ar(src, buf, doneAction: Done.freeSelf, loop: 0);
	}).add;
	SynthDef(\playBuffer, {
		arg out = 0, buf = 0;
		var playbuf;
		playbuf = PlayBuf.ar(1,buf);
		FreeSelfWhenDone.kr(playbuf);
		Out.ar(out, playbuf);
	}).add;

	b = Buffer.alloc(s, 44100 * 30.0, 1);
	m = ServerMeter.new(s, 4, 2);

})

({ 4.0.wait; 'start'.postln; x = Synth.new(\recordIntoBuffer, [\buf, b]);}.fork;)
y = Synth.new(\playBuffer, [\buf, b]);
b.write("/Users/jwy/Documents/GitHub/wesle002/shortnotes.aif");
