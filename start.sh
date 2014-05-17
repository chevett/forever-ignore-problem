#! /usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


rm -f "$DIR/log.txt"
./node_modules/.bin/forever start --uid "forever-ignore-problem" -l "$DIR/log.txt" -w --watchDirectory "$DIR/one" "$DIR/one/one.js";

tail -f log.txt&

sleep 2;
echo -e '\n'

echo "touching $DIR/one/one.js ... please wait";
touch "$DIR/one/one.js"
sleep 5;
echo -e 'cool. should have received a restart message.\n';


echo "touching $DIR/one/two/two.js ... please wait";
touch "$DIR/one/two/two.js"
sleep 5;
echo -e 'cool. no started message.\n';


echo "touching $DIR/one/two/.three/three.js ... please wait";
touch "$DIR/one/two/.three/three.js"
sleep 5;
echo -e 'Nooo, we were restarted but should NOT HAVE been, right?.\n';

./node_modules/.bin/forever stop "forever-ignore-problem"
