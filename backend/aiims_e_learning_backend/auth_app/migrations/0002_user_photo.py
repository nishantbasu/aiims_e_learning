# Generated by Django 3.1.1 on 2020-11-07 07:42

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('auth_app', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='photo',
            field=models.ImageField(default='null', upload_to='user_photos/%y'),
            preserve_default=False,
        ),
    ]
