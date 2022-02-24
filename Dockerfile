FROM python:3.9.0

WORKDIR /home/

RUN echo "testing"

RUN git clone https://github.com/tlsgn8483/pragmatic.git

WORKDIR /home/pragmatic

RUN pip install -r requirements.txt

RUN pip install gunicorn

RUN pip install mysqlclient

RUN echo "SECRET_KEY=django-insecure-v!)^^-j&gh=iu0%e_8ut^%tf79z&&!3yd$%b*s*5x6#r=(rnn*" > .env

RUN python manage.py collectstatic

EXPOSE 8000

CMD ["bash", "-c", "python manage.py migrate --settings=pragmatic.settings.deploy && gunicorn pragmatic.wsgi --env DJANGO_SETTINGS_MODULE=pragmatic.settings.deploy --bind 0.0.0.0:8000"]