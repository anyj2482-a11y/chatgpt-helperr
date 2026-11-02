import asyncio
import json
import urllib.request
import websockets

async def test():
    req = urllib.request.urlopen("http://127.0.0.1:9225/json/list")
    targets = json.loads(req.read().decode())
    ws_url = targets[0]["webSocketDebuggerUrl"]
    async with websockets.connect(ws_url) as ws:
        nav = {"id": 1, "method": "Page.navigate", "params": {"url": "https://chatgpt.com/"}}
        await ws.send(json.dumps(nav))
        await asyncio.sleep(2)

        eval_cmd = {
            "id": 2,
            "method": "Runtime.evaluate",
            "params": {
                "expression": "document.cookie = '__Secure-next-auth.session-token=mytesttoken; path=/; domain=.chatgpt.com; Secure; SameSite=Lax'; document.cookie"
            }
        }
        await ws.send(json.dumps(eval_cmd))
        while True:
            res = json.loads(await ws.recv())
            if res.get("id") == 2:
                print("Result of document.cookie:", res)
                break

asyncio.run(test())
