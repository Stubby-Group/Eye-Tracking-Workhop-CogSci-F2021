pacman::p_load(tidyverse, vroom)

## Locate the raw data
path_foraging = "~/Dropbox/Undervisning/8_FS2021/Eye tracking lab/Data/Foraging/"
path_soceng = "~/Dropbox/Undervisning/8_FS2021/Eye tracking lab/Data/Pupillometrics/"

## Bind the individual participants' sample data sets
foraging_samples <-
  vroom(list.files(
    path = path_foraging,
    pattern = "_samples.xls",
    full.names = TRUE
  ),
  na = ".") %>% 
  ## Downsample to 250Hz otherwise too large
  group_by(RECORDING_SESSION_LABEL, TRIAL_INDEX) %>% 
  mutate(.seq = seq(1:n())) %>% 
  filter(.seq %% 2 == 0)

## Do the same for fixations
foraging_fixations <-
  vroom(list.files(
    path = path_foraging,
    pattern = "_fixations.xls",
    full.names = TRUE
  ),
  na = ".")

## Do the same for saccades
foraging_saccades <-
  vroom(list.files(
    path = path_foraging,
    pattern = "_saccades.xls",
    full.names = TRUE
  ),
  na = ".")

foraging_saccades$CURRENT_SAC_AMPLITUDE <-
  as.numeric(sub(",", ".", foraging_saccades$CURRENT_SAC_AMPLITUDE, fixed = TRUE))
foraging_saccades$CURRENT_SAC_PEAK_VELOCITY <-
  as.numeric(sub(",", ".", foraging_saccades$CURRENT_SAC_PEAK_VELOCITY, fixed = TRUE))

## Repeate the procedure above for the Social Engagement experiment
soceng_samples <-
  vroom(list.files(
    path = path_soceng,
    pattern = "_samples.xls",
    full.names = TRUE,
  ),
  na = ".") %>% 
  ## Downsample to 250Hz otherwise too large
  group_by(RECORDING_SESSION_LABEL, TRIAL_INDEX) %>% 
  mutate(.seq = seq(1:n())) %>% 
  filter(.seq %% 2 == 0)

soceng_fixations <-
  vroom(list.files(
    path = path_soceng,
    pattern = "_fixations.xls",
    full.names = TRUE
  ),
  na = ".")

soceng_saccades <-
  vroom(list.files(
    path = path_soceng,
    pattern = "_saccades.xls",
    full.names = TRUE
  ),
  na = ".")

soceng_saccades$CURRENT_SAC_AMPLITUDE <-
  as.numeric(sub(",", ".", soceng_saccades$CURRENT_SAC_AMPLITUDE, fixed = TRUE))
soceng_saccades$CURRENT_SAC_PEAK_VELOCITY <-
  as.numeric(sub(",", ".", soceng_saccades$CURRENT_SAC_PEAK_VELOCITY, fixed = TRUE))

## Save everything to file
# write_csv(foraging_samples, "foraging_samples.csv")
# write_csv(foraging_fixations, "foraging_fixations.csv")
# write_csv(foraging_saccades, "foraging_saccades.csv")
# write_csv(soceng_samples, "soceng_samples.csv")
# write_csv(soceng_fixations, "soceng_fixations.csv")
# write_csv(soceng_saccades, "soceng_saccades.csv")