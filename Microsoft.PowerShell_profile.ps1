function unity-open {
    & "C:\Program Files\Unity\Hub\Editor\6000.2.10f1\Editor\Unity.exe" -projectPath $args
}

function npp {
    & "C:\Program Files\npp\notepad++.exe" $args
}

function btop {
	& "C:\Users\Micha\3rd-party\btop4win\btop4win.exe" $args
}

# Add paths
$pathsToAdd = @(
    "C:\Program Files\dotnet"
    "C:\Program Files\Git\cmd"
    "C:\Program Files\GitHub CLI"
    "C:\Program Files\nodejs"
    "C:\Users\Micha\.dotnet\tools"
    "C:\Users\Micha\AppData\Local\Microsoft\WindowsApps"
    "C:\Users\Micha\AppData\Local\Microsoft\WinGet\Links"
    "C:\Users\Micha\AppData\Local\Programs\Microsoft VS Code\bin"
    "C:\Users\Micha\AppData\Local\Programs\Ollama"
    "C:\Users\Micha\AppData\Local\Python\bin"
    "C:\Users\Micha\AppData\Local\Python\pythoncore-3.14-64\Scripts"
    "C:\Users\Micha\AppData\Roaming\npm"
    "C:\Users\Micha\AppData\Roaming\Programs\Zero Install"
    "C:\Users\Micha\3rd-party\ffmpeg\ffmpeg-2025-12-22-git-c50e5c7778-essentials_build\bin"
    "C:\Users\Micha\3rd-party\ripgrep\ripgrep-15.1.0-x86_64-pc-windows-msvc\complete"
    "C:\Users\Micha\3rd-party\winfetch"
	"C:\platform-tools"
	"C:\Windows\System32"
)

foreach ($path in $pathsToAdd) {
    if (Test-Path $path) {
        $env:Path += ";$path"
    }
}