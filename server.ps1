$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:8000/")
$listener.Start()
Write-Host "Server started at http://localhost:8000/"
while ($listener.IsListening) {
    $context = $listener.GetContext()
    $requestUrl = $context.Request.Url.LocalPath
    $filePath = Join-Path (Get-Location) $requestUrl.TrimStart('/')
    if ($requestUrl -eq '/') {
        $filePath = Join-Path (Get-Location) 'dashboard-builder-v5.9.html'
    }
    if (Test-Path $filePath -PathType Leaf) {
        $content = Get-Content $filePath -Raw -Encoding UTF8
        $context.Response.ContentType = switch ([IO.Path]::GetExtension($filePath)) {
            '.html' { 'text/html' }
            '.css' { 'text/css' }
            '.js' { 'application/javascript' }
            default { 'application/octet-stream' }
        }
        $buffer = [System.Text.Encoding]::UTF8.GetBytes($content)
        $context.Response.ContentLength64 = $buffer.Length
        $context.Response.OutputStream.Write($buffer, 0, $buffer.Length)
    } else {
        $context.Response.StatusCode = 404
        $context.Response.StatusDescription = 'Not Found'
    }
    $context.Response.OutputStream.Close()
}