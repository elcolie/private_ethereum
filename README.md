## Getting Started

1. `./startnode.sh` or `startnode.sh` to start miner. Assume you have initialize chain already
   1. Here are instruction to setup private node
      1. https://www.youtube.com/watch?v=m_Ry0LZjoRQ&ab_channel=ChainSkills
      2. https://www.youtube.com/watch?v=A5V2jdLi5mI&ab_channel=ChainSkills
2. cd `palm_web`
3. `flutter build web`
4. `cd build`
5. `http-server web/ -S -C cert.pem` or  `python -m http.server 8080` in `build/web` directory
6. beauty_coin runs `python manage.py runserver 0.0.0.0:8000` or `gunicorn beauty_coin.wsgi --bind 0.0.0.0:5000 --chdir=beauty_coin --reload`

https://youtu.be/O4-tcPI1xp0

## Deploy with Caddy
1. Configure DNS for frontend and backend
2. Follow https://websiteforstudents.com/how-to-install-caddy-in-ubuntu/
3. Use `Caddyfile`
