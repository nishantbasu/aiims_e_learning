# Generated by Django 3.1.1 on 2021-01-29 12:52

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Faculty',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('faculty_name', models.CharField(max_length=100)),
                ('specialization', models.CharField(max_length=200)),
                ('about', models.CharField(max_length=200)),
                ('photo', models.ImageField(default='/faculty_photos/20/default.jpg', upload_to='faculty_photos/%y')),
            ],
        ),
    ]
