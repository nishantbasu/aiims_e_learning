# Generated by Django 3.1.1 on 2020-12-16 19:24

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('auth_app', '0009_remove_user_photo'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='evaluation_attempted',
            field=models.BooleanField(default=False),
        ),
    ]
