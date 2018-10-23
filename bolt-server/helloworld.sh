#!/bin/bash
cat > test.json << EOF
{
  "target": {
    "hostname": "$(hostname -f)",
    "user": "root",
    "password": "puppetlabs",
    "host-key-check": false
  },
  "task": {
    "name": "echo",
    "metadata": {
      "description": "Echo a message",
      "parameters": {
        "message": "Default string"
      }
    },
    "file": {
      "filename": "echo.sh",
      "file_content": "IyEvdXNyL2Jpbi9lbnYgYmFzaAplY2hvICRQVF9tZXNzYWdlCg==\n"
    }
  },
  "parameters": {
    "message": "Hello world"
  }
}
EOF

curl -X POST -H "Content-Type: application/json" -d @test.json --cacert $(puppet config print localcacert) --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey) https://$(hostname -f):62658/ssh/run_task
