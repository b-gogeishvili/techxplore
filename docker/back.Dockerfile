FROM python:3

ENV PYTHONUNBUFFERED=1

WORKDIR /code

COPY . /code/

RUN pip install -r requirements.txt

RUN python manage.py collectstatic --noinput

CMD ["sh", "-c", "python manage.py migrate && gunicorn billsplitter.wsgi:application --bind 0.0.0.0:80"]