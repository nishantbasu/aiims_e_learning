# Generated by Django 3.1.1 on 2020-11-07 07:57

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('auth_app', '0005_auto_20201107_1325'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='photo',
            field=models.ImageField(default='default.jpg', upload_to='user_photos/%y'),
        ),
    ]
