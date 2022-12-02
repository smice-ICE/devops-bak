#!/bin/bash

url='https://open.feishu.cn/open-apis/bot/v2/hook/64e16db7-12a5-4877-be16-4c4a13a3182b'
header='Content-Type: application/json'
data=$(cat <<- EOF
{
  "msg_type": "post",
  "content": {
    "post": {
      "zh_cn": {
        "title": "starland build",
        "content": [
          [
            {
              "tag": "at",
              "user_id": "all",
              "user_name": "所有人"
            }
          ],
          [
            {
              "tag": "text",
              "text": "构建完成"
            }
          ],
          [
            {
              "tag": "text",
              "text": "URL: "
            },
            {
              "tag": "a",
              "text": "${BUILD_TAG}",
              "href": "${BUILD_URL}"
            }
          ],
          [
            {
              "tag": "text",
              "text": "Release: "
            },
            {
              "tag": "text",
              "text": "${release_version}.zip"
            }
          ]

        ]
      }
    }
  }
}
EOF
)

curl -X POST -H "$header" -d "${data}" ${url}

