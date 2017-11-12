const _pauldijou$elm_node$Native_Node_Http = function () {
  const http = require('http');

  function createServer(options) {
    const server = http.createServer();

    return {
      start: function start({ onRequest }) {
        return new Promise(resolve => {
          server.on('request', (request, response) => {
            const body = [];
            request.on('data', chunk => {
              body.push(chunk);
            }).on('end', () => {
              request.body = Buffer.concat(body).toString();
              onRequest(response, request);
            });
          });

          server.listen(options, resolve);
        });
      },
      stop: function stop() {
        return new Promise(resolve => {
          server.close(() => {
            resolve()
          });
        });
      }
    }
  }

  function init(replier) {
    return replier;
  }

  function withStatusCode(code, replier) {
    replier.statusCode = code;
    return replier;
  }

  function withHeader(header, replier) {
    replier.setHeader(header.name, header.value);
    return replier;
  }

  function withBody(body, replier) {
    replier.write(body);
    return replier;
  }

  function send(end, replier) {
    if (end) {
      replier.end();
    }
    return replier;
  }

  return {
    createServer: createServer,
    init: init,
    withStatusCode: F2(withStatusCode),
    withHeader: F2(withHeader),
    withBody: F2(withBody),
    send: F2(send)
  }
}()
