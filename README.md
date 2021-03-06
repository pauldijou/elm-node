# elm-node

Elm package exposing some of Node APIs.

## Supported APIs

Name | Elm | Node
-----|-----|-----
Exit Codes | [Elm module](https://github.com/pauldijou/elm-node/blob/master/src/Node/ExitCodes.elm) | [Node API](https://nodejs.org/docs/latest/api/process.html#process_exit_codes)
File System | [Elm module](https://github.com/pauldijou/elm-node/blob/master/src/Node/FileSystem.elm) | [Node API](https://nodejs.org/api/fs.html)
Path | [Elm module](https://github.com/pauldijou/elm-node/blob/master/src/Node/Path.elm) | [Node API](https://nodejs.org/docs/latest/api/path.html)
Process | [Elm module](https://github.com/pauldijou/elm-node/blob/master/src/Node/Process.elm) | [Node API](https://nodejs.org/docs/latest/api/process.html)
Stats | [Elm module](https://github.com/pauldijou/elm-node/blob/master/src/Node/Stats.elm) | [Node API](https://nodejs.org/api/fs.html#fs_class_fs_stats)
Util | [Elm module](https://github.com/pauldijou/elm-node/blob/master/src/Node/Util.elm) | [Node API](https://nodejs.org/docs/latest/api/util.html)

## Tests

If you need to run the tests, just use `yarn install && yarn deps && yarn test`.

**Warning** Some of the tests rely on the platform you are using (Windows, Linux, OSX, ...) so they might not be working on your machine. Linux should be fully supported, maybe also OSX, probably not Windows. Feel free to do PR to improve those tests with your current platform.

## License

This software is licensed under the Apache 2 license, quoted below.

Copyright Paul Dijou ([http://pauldijou.fr](http://pauldijou.fr)).

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this project except in compliance with the License. You may obtain a copy of the License at [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
