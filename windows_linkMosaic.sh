#!/bin/bash

###############################################################################
#       ----------------------------------------------------------
#   Mosaic | OF Visual Patching Developer Platform
#
#         Copyright (c) 2020 Emanuele Mazza aka n3m3da
#
#         Mosaic is distributed under the MIT License. This gives everyone the
#   freedoms to use Mosaic in any context: commercial or non-commercial,
#   public or private, open or closed source.
#
#   See https://github.com/d3cod3/Mosaic for documentation
#       ----------------------------------------------------------
#
#
#         Mosaic auto compile/install script for windows/msys2 64 bit
#
###############################################################################


CMD=" main.o MosaicTheme.o ofApp.o SplashScreen.o TextEditor.o ofxAssimpAnimation.o ofxAssimpMeshHelper.o ofxAssimpModelLoader.o ofxAssimpTexture.o ofxBaseGui.o ofxButton.o ofxColorPicker.o ofxGuiGroup.o ofxInputField.o ofxLabel.o ofxPanel.o ofxSlider.o ofxSliderGroup.o ofxToggle.o ofxKinectExtras.o ofxKinect.o audio.o cameras.o core.o flags.o loader.o registration.o tilt.o usb_libusb10.o ofxNetworkUtils.o ofxTCPClient.o ofxTCPManager.o ofxTCPServer.o ofxUDPManager.o ofxCvColorImage.o ofxCvContourFinder.o ofxCvFloatImage.o ofxCvGrayscaleImage.o ofxCvHaarFinder.o ofxCvImage.o ofxCvShortImage.o ofxOscBundle.o ofxOscMessage.o ofxOscParameterSync.o ofxOscReceiver.o ofxOscSender.o IpEndpointName.o NetworkingUtils.o UdpSocket.o OscOutboundPacketStream.o OscPrintReceivedElements.o OscReceivedElements.o OscTypes.o ofxSvg.o ofxVectorGraphics.o CreEPS.o ofxXmlSettings.o tinyxml.o tinyxmlerror.o tinyxmlparser.o ofxAAMultiPitchKlapuriAlgorithm.o ofxAAOnsetsAlgorithm.o ofxAudioAnalyzer.o ofxAudioAnalyzerAlgorithms.o ofxAudioAnalyzerUnit.o ofxFftw.o algorithm.o cartesiantopolar.o magnitude.o polartocartesian.o essentia_algorithms_reg.o beatogram.o meter.o barkextractor.o extractor.o keyextractor.o levelextractor.o lowlevelspectraleqloudextractor.o lowlevelspectralextractor.o rhythmdescriptors.o tonalextractor.o tuningfrequencyextractor.o allpass.o bandpass.o bandreject.o dcremoval.o equalloudness.o highpass.o iir.o lowpass.o movingaverage.o danceability.o dynamiccomplexity.o fadedetection.o intensity.o pca.o sbic.o audioonsetsmarker.o fileoutputproxy.o beatsloudness.o beattrackerdegara.o beattrackermultifeature.o bpmhistogram.o bpmhistogramdescriptors.o bpmrubato.o harmonicbpm.o loopbpmconfidence.o loopbpmestimator.o noveltycurve.o noveltycurvefixedbpmestimator.o onsetdetection.o onsetdetectionglobal.o onsetrate.o onsets.o percivalbpmestimator.o percivalenhanceharmonics.o percivalevaluatepulsetrains.o rhythmextractor.o rhythmextractor2013.o rhythmtransform.o singlebeatloudness.o superfluxextractor.o superfluxnovelty.o superfluxpeaks.o temposcalebands.o tempotap.o tempotapdegara.o tempotapmaxagreement.o tempotapticks.o aftermaxtobeforemaxenergyratio.o derivativesfx.o flatnesssfx.o logattacktime.o maxtototal.o mintototal.o pitchsalience.o strongdecay.o tctototal.o barkbands.o energyband.o energybandratio.o erbbands.o flatnessdb.o flux.o frequencybands.o gfcc.o hfc.o hpcp.o maxmagfreq.o melbands.o mfcc.o panning.o rolloff.o spectralcentroidtime.o spectralcomplexity.o spectralcontrast.o spectralpeaks.o spectralwhitening.o strongpeak.o triangularbands.o autocorrelation.o binaryoperator.o binaryoperatorstream.o bpf.o chromagram.o clipper.o constantq.o crosscorrelation.o cubicspline.o dct.o derivative.o envelope.o fftw.o fftwcomplex.o framecutter.o frametoreal.o ifftw.o maxfilter.o monomixer.o multiplexer.o noiseadder.o overlapadd.o peakdetection.o powerspectrum.o realaccumulator.o replaygain.o scale.o silencerate.o slicer.o spectrum.o spline.o startstopsilence.o stereodemuxer.o trimmer.o unaryoperator.o unaryoperatorstream.o vectorrealaccumulator.o warpedautocorrelation.o windowing.o centralmoments.o centroid.o crest.o decrease.o distributionshape.o energy.o entropy.o flatness.o geometricmean.o instantpower.o mean.o median.o poolaggregator.o powermean.o rawmoments.o rms.o singlegaussian.o variance.o harmonicmask.o harmonicmodelanal.o hprmodelanal.o hpsmodelanal.o resamplefft.o sinemodelanal.o sinemodelsynth.o sinesubtraction.o sprmodelanal.o sprmodelsynth.o spsmodelanal.o spsmodelsynth.o stochasticmodelanal.o stochasticmodelsynth.o duration.o effectiveduration.o larm.o leq.o loudness.o loudnessebur128.o loudnessebur128filter.o loudnessvickers.o lpc.o zerocrossingrate.o chordsdescriptors.o chordsdetection.o chordsdetectionbeats.o dissonance.o harmonicpeaks.o highresolutionfeatures.o inharmonicity.o key.o multipitchklapuri.o multipitchmelodia.o oddtoevenharmonicenergyratio.o pitchcontours.o pitchcontoursegmentation.o pitchcontoursmelody.o pitchcontoursmonomelody.o pitchcontoursmultimelody.o pitchfilter.o pitchmelodia.o pitchsaliencefunction.o pitchsaliencefunctionpeaks.o pitchyin.o pitchyinfft.o predominantpitchmelodia.o tonicindianartmusic.o tristimulus.o tuningfrequency.o vibrato.o configurable.o connector.o debugging.o essentia.o essentiautil.o parameter.o pool.o range.o network.o networkparser.o splineutil.o accumulatoralgorithm.o devnull.o poolstorage.o ringbufferinput.o ringbufferoutput.o ringbuffervectoroutput.o sinkbase.o sourcebase.o streamingalgorithm.o streamingalgorithmcomposite.o streamingalgorithmwrapper.o stringutil.o asciidag.o asciidagparser.o synth_utils.o ofxAudioFile.o ofxBTrack.o BTrack.o OnsetDetectionFunction.o kiss_fft.o samplerate.o src_linear.o src_sinc.o src_zoh.o ofxChromaKeyShader.o ETF.o fdog.o Calibration.o ContourFinder.o Distance.o Flow.o Helpers.o Kalman.o ObjectFinder.o RunningBackground.o Tracker.o Utilities.o Wrappers.o ofxDatGuiComponent.o ofxSmartFont.o ofxDatGui.o ofxFFmpegRecorder.o ofxFontStash.o fontstash_v1.o stb_truetype.o ofxEditor.o ofxEditorColorScheme.o ofxEditorFont.o ofxEditorSettings.o ofxEditorSyntax.o ofxFileDialog.o ofxGLEditor.o ofxRepl.o Unicode.o ofxHistoryPlot.o ofxJSONElement.o jsoncpp.o BaseEngine.o DefaultTheme.o EngineGLFW.o EngineOpenGLES.o EngineVk.o Gui.o Helpers.o ofxImGuiLoggerChannel.o imgui.o imgui_demo.o imgui_draw.o imgui_widgets.o ofxInfiniteCanvas.o ofxAddonsCoreLuaBindings.o ofxLuaBindings.o ofxLua.o ofxLuaFileWriter.o lapi.o lauxlib.o lbaselib.o lbitlib.o lcode.o lcorolib.o lctype.o ldblib.o ldebug.o ldo.o ldump.o lfs.o lfunc.o lgc.o linit.o liolib.o llex.o lmathlib.o lmem.o loadlib.o lobject.o lopcodes.o loslib.o lparser.o lstate.o lstring.o lstrlib.o ltable.o ltablib.o ltm.o lundump.o lutf8lib.o lvm.o lzio.o ofxRtMidiIn.o ofxRtMidiOut.o ofxBaseMidi.o ofxMidi.o ofxMidiClock.o ofxMidiIn.o ofxMidiMessage.o ofxMidiOut.o ofxMidiTimecode.o RtMidi.o ofxMtlMapping2DControls.o ofxMSAInteractiveObject.o ofxMtlMapping2D.o ofxMtlMapping2DShapes.o ofxUI2DGraph.o ofxUI2DPad.o ofxUIBaseDraws.o ofxUIBiLabelSlider.o ofxUIButton.o ofxUICanvas.o ofxUICircleSlider.o ofxUIDragableLabelButton.o ofxUIDropDownList.o ofxUIEventArgs.o ofxUIFPS.o ofxUIFPSSlider.o ofxUIImage.o ofxUIImageButton.o ofxUIImageSampler.o ofxUIImageSlider.o ofxUIImageToggle.o ofxUILabel.o ofxUILabelButton.o ofxUILabelToggle.o ofxUIMinimalSlider.o ofxUIMovingGraph.o ofxUIMultiImageButton.o ofxUIMultiImageToggle.o ofxUINumberDialer.o ofxUIRadio.o ofxUIRangeSlider.o ofxUIRectangle.o ofxUIRotarySlider.o ofxUIScrollableCanvas.o ofxUISlider.o ofxUISortableList.o ofxUISpacer.o ofxUISpectrum.o ofxUISuperCanvas.o ofxUITabBar.o ofxUITextArea.o ofxUITextInput.o ofxUIToggle.o ofxUIToggleMatrix.o ofxUIValuePlotter.o ofxUIWaveform.o ofxUIWidget.o ofxUIWidgetWithLabel.o ofxMtlMapping2DSettings.o ofxMtlMapping2DEllipse.o ofxMtlMapping2DGrid.o ofxMtlMapping2DInput.o ofxMtlMapping2DMask.o ofxMtlMapping2DPolygon.o ofxMtlMapping2DQuad.o ofxMtlMapping2DShape.o ofxMtlMapping2DTriangle.o ofxMtlMapping2DVertex.o ofxParagraph.o SequencerBridge.o SequencerGateOutput.o SequencerValueOutput.o ToGateTrigger.o TriggerControl.o TriggerGeiger.o ValueControl.o FDLConvolver.o Amp.o BasicNodes.o BufferShell.o ExternalInput.o Formula.o leftSum.o operators.o PatchNode.o Preparable.o Processor.o Switch.o AllPassDelay.o Delay.o SRDelay.o AbsoluteValue.o EnvelopeFollower.o GainComputer.o LHDelay.o PositiveValue.o RMSDetector.o SquarePeakDetector.o ADSR.o AHR.o EnvelopeStage.o APF1.o APF4.o BiquadAPF2.o BiquadBase.o BiquadBPF2.o BiquadHighShelf.o BiquadHPF2.o BiquadLowShelf.o BiquadLPF2.o BiquadNotch2.o BiquadPeakEQ.o MultiLadder4.o OnePole.o SVF2.o FFTWorker.o UsesSlew.o BLEPBased.o BLEPTable.o BLEPSaw.o DPWTri.o Oscillator.o OscillatorVariShape.o CheapPulse.o CheapSaw.o CheapSine.o CheapTri.o SineFB.o ClockedPhasor.o LFOPhasor.o PhasorShifter.o PMPhasor.o DataOsc.o DataTable.o WaveTable.o WaveTableOsc.o TriggeredRandom.o WhiteNoise.o BandLimit.o DownSampler.o IIRDownSampler2x.o IIRUpSampler2x.o UpSampler.o ZeroDownSampler.o ZeroUpSampler.o GrainBased.o GrainTable.o GrainWindow.o SampleBuffer.o Sampler.o Bitcruncher.o Decimator.o SampleAndHold.o Saturator1.o Saturator2.o SoftClip.o BipolarToUnipolar.o DBtoLin.o FreqToMs.o LinToDB.o MaxValue.o OneBarTimeMs.o OneMinusInput.o PitchToFreq.o SamplesDelay.o incrementCalculator.o sanity_check.o random.o activate.o allocator.o blep.o dsp_windows.o Clockable.o ExtSequencer.o MessageBuffer.o Compressor.o Ducker.o DimensionChorus.o AAHighShelfEQ.o AALowShelfEQ.o AAPeakEQ.o HighCut.o HighShelfEQ.o LowCut.o LowShelfEQ.o PeakEQ.o CombFilter.o PhaserFilter.o SVFilter.o VAFilter.o ClockedLFO.o DataOscillator.o FMOperator.o LFO.o TableOscillator.o VAOscillator.o BasiVerb.o IRVerb.o GrainCloud.o TriggeredGrain.o LinearCrossfader.o Panner.o BitNoise.o ComputerKeyboard.o Engine.o MidiCCBuffers.o MidiKeysBuffers.o OscParser.o MidiControls.o MidiIn.o MidiKeys.o MidiOut.o MidiPads.o ofxPDSPFunctions.o OscInput.o OscOutput.o Parameter.o ParameterAmp.o ParameterGain.o SampleBufferPlotter.o Scope.o SerialOut.o Wrapper.o Function.o Sequence.o SequencerMessage.o SequencerProcessor.o SequencerSection.o stockBehaviors.o AudioFFT.o tinyfiledialogs.o ofxMSATimer.o ofxTextInputField.o ofxTimecode.o ofxTimeline.o ofxTLBangs.o ofxTLColors.o ofxTLColorTrack.o ofxTLCurves.o ofxTLEmptyKeyframes.o ofxTLEmptyTrack.o ofxTLInOut.o ofxTLKeyframes.o ofxTLLFO.o ofxTLNotes.o ofxTLPage.o ofxTLPageTabs.o ofxTLSwitches.o ofxTLTicker.o ofxTLTrack.o ofxTLTrackHeader.o ofxTLZoomer.o ofxTimeMeasurements.o objectFactory.o DraggableVertex.o AudioAnalyzer.o BeatExtractor.o BPMExtractor.o CentroidExtractor.o DissonanceExtractor.o FftExtractor.o HFCExtractor.o HPCPExtractor.o InharmonicityExtractor.o MelBandsExtractor.o MFCCExtractor.o OnsetExtractor.o PitchExtractor.o PowerExtractor.o RMSExtractor.o RollOffExtractor.o TristimulusExtractor.o ArduinoSerial.o KeyPressed.o KeyReleased.o MidiKey.o MidiKnob.o MidiPad.o MidiReceiver.o MidiScore.o MidiSender.o OscReceiver.o OscSender.o BackgroundSubtraction.o ChromaKey.o ColorTracking.o ContourTracking.o HaarTracking.o MotionDetection.o OpticalFlow.o BangMultiplexer.o BangToFloat.o DataToFile.o DataToTexture.o FileToData.o FloatMultiplexer.o FloatsToVector.o TextureToData.o VectorAt.o VectorConcat.o VectorGate.o VectorMultiply.o ImageExporter.o ImageLoader.o mo2DPad.o moBang.o moComment.o moMessage.o moPlayerControls.o moSignalViewer.o moSlider.o moSonogram.o moTextBuffer.o moTimeline.o moTrigger.o moVideoViewer.o moVUMeter.o AND.o BiggerThan.o Counter.o DelayBang.o DelayFloat.o Equality.o Gate.o Inequality.o Inverter.o LoadBang.o OR.o Select.o SmallerThan.o Spigot.o TimedSemaphore.o Add.o Clamp.o Constant.o Divide.o Map.o Metronome.o Module.o Multiply.o Range.o SimpleNoise.o SimpleRandom.o Smooth.o Subtract.o LuaScript.o ShaderObject.o AudioDevice.o AudioExporter.o AudioGate.o Crossfader.o Mixer.o NoteToFrequency.o Oscillator.o OscPulse.o OscSaw.o OscTriangle.o Panner.o pdspADSR.o pdspAHR.o pdspBitCruncher.o pdspBitNoise.o pdspChorusEffect.o pdspCombFilter.o pdspCompressor.o pdspDataOscillator.o pdspDecimator.o pdspDelay.o pdspDucker.o pdspHiCut.o pdspLFO.o pdspLowCut.o pdspResonant2PoleFilter.o pdspReverb.o pdspWhiteNoise.o QuadPanner.o SigMult.o SignalTrigger.o SoundfilePlayer.o KinectGrabber.o PixelsToTexture.o TextureToPixels.o VideoCrop.o VideoDelay.o VideoExporter.o VideoGate.o VideoGrabber.o VideoPlayer.o VideoStreaming.o VideoTimelapse.o VideoTransform.o LivePatching.o OutputWindow.o ProjectionMapping.o ofxVisualProgramming.o PatchObject.o Controller.o WarpBase.o WarpBilinear.o WarpPerspective.o WarpPerspectiveBilinear.o /opt/openFrameworks/libs/openFrameworksCompiled/lib/msys2/libopenFrameworks.a /opt/openFrameworks/addons/ofxSvg/libs/svgtiny/lib/msys2/libsvgtiny.a /opt/openFrameworks/addons/ofxAudioAnalyzer/libs/fftw3f/lib/msys2/libfftw3f-3.dll  -lpthread -mwindows /opt/openFrameworks/libs/kiss/lib/msys2/libkiss.a /opt/openFrameworks/libs/pugixml/lib/msys2/pugixml.a /opt/openFrameworks/libs/rtAudio/lib/msys2/librtaudio.a /opt/openFrameworks/libs/tess2/lib/msys2/libtess2.a /opt/openFrameworks/libs/uriparser/lib/msys2/liburiparser.a /opt/openFrameworks/libs/videoInput/lib/msys2/libvideoinput.a -LC:/msys64/mingw64/lib -lcairo -lz -lssl -lcrypto -lglew32 -lglfw3 -lcurl -lopenal -lsndfile -lmpg123 -lassimp -lusb-1.0 -lopencv_gapi -lopencv_stitching -lopencv_alphamat -lopencv_aruco -lopencv_bgsegm -lopencv_ccalib -lopencv_dnn_objdetect -lopencv_dnn_superres -lopencv_dpm -lopencv_highgui -lopencv_face -lopencv_fuzzy -lopencv_hdf -lopencv_hfs -lopencv_img_hash -lopencv_intensity_transform -lopencv_line_descriptor -lopencv_ovis -lopencv_quality -lopencv_rapid -lopencv_reg -lopencv_rgbd -lopencv_saliency -lopencv_sfm -lopencv_stereo -lopencv_structured_light -lopencv_phase_unwrapping -lopencv_superres -lopencv_optflow -lopencv_surface_matching -lopencv_tracking -lopencv_datasets -lopencv_text -lopencv_dnn -lopencv_plot -lopencv_videostab -lopencv_videoio -lopencv_xfeatures2d -lopencv_shape -lopencv_ml -lopencv_ximgproc -lopencv_video -lopencv_xobjdetect -lopencv_objdetect -lopencv_calib3d -lopencv_imgcodecs -lopencv_features2d -lopencv_flann -lopencv_xphoto -lopencv_photo -lopencv_imgproc -lopencv_core -lxml2 -lksuser -lopengl32 -lgdi32 -lmsimg32 -lglu32 -ldsound -lwinmm -lstrmiids -luuid -lole32 -loleaut32 -lsetupapi -lwsock32 -lws2_32 -lIphlpapi -lComdlg32 -lfreeimage -lboost_filesystem-mt -lboost_system-mt -lfreetype -lcairo"

/mingw32/bin/g++ -o ../bin/Mosaic.exe $CMD
