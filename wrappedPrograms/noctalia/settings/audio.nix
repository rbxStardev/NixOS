{self, ...}: {
  flake.wrappersModules.noctalia-shell = {...}: {
      settings = {
        audio = {
          volumeStep = 5;
          volumeOverdrive = false;
          spectrumFrameRate = 30;
          visualizerType = "linear";
          spectrumMirrored = true;
          mprisBlacklist = [];
          preferredPlayer = "";
          volumeFeedback = false;
          volumeFeedbackSoundFile = "";
        };
      };
  };
}
