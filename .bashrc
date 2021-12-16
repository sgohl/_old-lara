function Composer() {
  docker run --rm -it -v $PWD:/app:Z composer ${@}
}
function Php() {
  case $1 in
    bash) 
      docker run -it --rm --network laravel -v $PWD:/www:Z -w /www --user $(id -u) php:local bash
    ;;
    *)
      CMD="php ${@}"
      docker run -it --rm --network laravel -v $PWD:/www:Z -w /www --user $(id -u) php:local bash -c "${CMD}"
    ;;
  esac
}
alias composer=Composer
alias php=Php

## NODEJS helpers
NODE=lts

function npm
{
  node npm ${@}
}
function yarn
{
  node yarn ${@}
}
function npx
{
  node npx $@
}
function node
{
  unset EXEC
  unset NODEUSER
  case $1 in
    sh|shell|bash)
      CMD='bash'
    ;;
    a|attach|enter)
      EXEC=true
    ;;
    *npm*)
      shift
      CMD="npm ${@}"
    ;;
    *yarn*)
      shift
      CMD="yarn ${@}"
    ;;
    *npx*)
      shift
      CMD="npx ${@}"
    ;;
    *)
      CMD="node ${@}"
    ;;
  esac
  case $2 in *root*) NODEUSER=root ;; esac
  if [[ -n $EXEC ]]
  then
    docker exec -it --user ${NODEUSER:-node} node bash
  else
    if [[ $(docker ps -a -f name=node -q | wc -l) -gt 0 ]]; then docker rm -f node; fi
	docker run -it --rm --name node --user ${NODEUSER:-node} --net=host -v $PWD:$PWD --workdir $PWD node:${NODE:-lts} bash -c "${CMD}"
  fi
}