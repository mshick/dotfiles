gcloud_path="$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
gcloud_completion="$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

if test -f $gcloud_path
then
  source $gcloud_path
  source $gcloud_completion
fi
