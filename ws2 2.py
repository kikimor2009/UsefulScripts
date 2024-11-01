import sys
reload(sys)
sys.setdefaultencoding('utf-8')
import websocket, time, re 
from urllib2 import urlopen
from urllib2 import URLError
from urllib2 import Request
from websocket import WebSocketTimeoutException
sys.stdout = sys.stderr
import logging
import ssl

secure = True
http_protocol = 'http'
ws_protocol = 'ws'
if secure:
    http_protocol = 'https'
    ws_protocol = 'wss'
    
# host, port = ('cpppgstress1-gpas.crossperf.eu', '443')
host, port = ('openapi-stg1.egalacoral.com', '443')

def create_conn():
    start_time = time.time()
    unix_timestamp_with_ms = str(int(time.time()) * 1000)

    unix_timestamp_with_ms = str(int(time.time()) * 1000)
    url = http_protocol+'://' + host + ':' + port + '/socket.io/1?t='+unix_timestamp_with_ms
    print url
    req = Request(url, None, {})
    resp = ''
    output = ''
    try:
        # print 'start http... {0}'.format(url)
        resp = urlopen(req, None, 50)
        print 'end http: {}ms'.format((time.time() - start_time)*1000.0)
    except URLError, e:
        print 'WebSocket server error message: Got an exception trying to execute %s.  raw error:>>> %s' % (url, e)
        raise
    except:
        raise

    if resp.getcode() == 200:
        response = resp.readline()
        (sid, hbtimeout, ctimeout, supported) = response.split(":")
        supportedlist = supported.split(",")
        # print response
        if "websocket" not in supportedlist:
            print 'WebSocket server error message: Looks like "websocket" is not supported. raw_response>>> %s' % response
    else:
        print 'WebSocket server error message: Got unexpected response code - %s' % resp.getcode()

    ws_url = ws_protocol+'://' + host + ':' + port + '/socket.io/1/websocket/'+sid

    ws = websocket.create_connection(ws_url)
    # print ('Finished WS part for connection creation')
    end_time = time.time()
    #output += str(ws) + 'websocket.WebSocket object successfully created on Python ws server\n'
    print "WS conn created: duration=%f ms" % ((end_time - start_time)*1000.0)

    print output
    print ws.recv()
    end_time = time.time()
    print "Got response: duration=%f ms" % ((end_time - start_time)*1000.0)
    
for i in range(1,100):
    create_conn()