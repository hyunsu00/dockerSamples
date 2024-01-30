const express = require('express')
const app = express()
//앱은 서버를 시작하며 3000번 포트에서 연결을 청취함
const port = 3000

//루트 URL(/) 또는 라우트에 대한 요청에 “Hello World!”로 응답
app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})