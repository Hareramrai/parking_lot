def run_command(pty, command)
  stdout, stdin, _pid = pty
  stdin.puts command
  sleep(0.3)
  stdout.readline
end

def fetch_stdout(pty)
  stdout, _stdin, _pid = pty
  res = []
  while true
    begin
      Timeout.timeout 0.5 do
        res << stdout.readline
      end
    rescue EOFError, Errno::EIO, Timeout::Error
      break
    end
  end

  res.join('').gsub(/\r/, '')
end
