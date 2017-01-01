import os
import sys

from .base import Base
from .base import RssReaderDb

from sqlalchemy.orm import relationship
from sqlalchemy import UniqueConstraint

import datetime
from sqlalchemy import (
    Column,
    ForeignKey,
    Integer,
    String,
    Boolean,
    ForeignKey,
    DateTime,
    Sequence,
    Float,
    Text
)    


class RssUrls(Base):
    __tablename__ = 'rss_url'
    idRssUrl = Column(Integer, primary_key=True)
    diario = Column(String(128), nullable=False)
    seccion = Column(String(128), nullable=False)
    descripcion = Column(String(128), nullable=False)
    url = Column(String(500), nullable=False)
    habilitado =  Column(Boolean,default=False)
    creado_por =  Column(String(20), nullable=False)
    fecha_creacion =  Column(DateTime, default=datetime.datetime.now)
    UniqueConstraint('rss_url', name='ux_codigo')

class Feeds(Base):
    __tablename__ = 'rss_feed'
    idRssFeed = Column(Integer, primary_key=True)
    idRssUrl = Column(Integer, ForeignKey('rss_url.idRssUrl'))
    title= Column(String(2560), nullable=False)
    link= Column(String(500), nullable=False)
    description = Column(String(1000), nullable=False)
    pubDate  =  Column(DateTime)
    creado_por =  Column(String(20), nullable=False)
    fecha_proceso =  Column(DateTime)
    fecha_parseo =  Column(DateTime)
    fecha_creacion =  Column(DateTime, default=datetime.datetime.now)
    category =  Column(String(256), nullable=True)
    rssUrls = relationship(RssUrls)

class Cliente(Base):
    __tablename__ = 'cliente'
    id = Column(Integer, primary_key=True)
    nombre = Column(String(500), nullable=False)
    codigo =  Column(String(25), nullable=False,unique=True)
    habilitado =  Column(Boolean,default=False)
    creado_por =  Column(String(20), nullable=False)
    fecha_creacion =  Column(DateTime, default=datetime.datetime.now)
    UniqueConstraint('codigo', name='ux_codigo')

class Vigencia(Base):
    __tablename__ = 'vigencia_cliente'
    id = Column(Integer, primary_key=True)
    cliente_id = Column(Integer, ForeignKey('cliente.id'))
    unidades_adquiridas= Column(Integer, nullable=False)
    unidades_procesadas= Column(Integer, nullable=False)
    vigencia_desde  =  Column(DateTime, nullable=False)
    vigencia_hasta=  Column(DateTime, nullable=False)
    fecha_creacion =  Column(DateTime, default=datetime.datetime.now)
    creado_por =  Column(String(20), nullable=False)
    cliente = relationship(Cliente)

class Texto(Base):
    __tablename__ = 'texto'
    id = Column(Integer, primary_key=True)
    cliente_id = Column(Integer, ForeignKey('cliente.id'))
    source_id = Column(String(500), nullable=True)
    source_category= Column(String(128), nullable=True)
    source_category_sub= Column(String(128), nullable=True)
    source_field_name= Column(Text, nullable=False)
    source_date=Column(DateTime, nullable=True)
    texto = Column(Text, nullable=False)
    fecha_proceso =  Column(DateTime, nullable=True)
    fecha_creacion =  Column(DateTime, default=datetime.datetime.now)
    creado_por =  Column(String(20), nullable=False)
    cliente = relationship(Cliente)

class Palabra(Base):
    __tablename__ = 'palabra'
    id = Column(Integer, primary_key=True)
    palabra = Column(String(250), nullable=False)
    creado_por =  Column(String(20), nullable=False)

class TextoPalabras(Base):
    __tablename__ = 'texto_palabras'
    id = Column(Integer, primary_key=True)
    texto_id = Column(Integer, ForeignKey('texto.id'))
    palabra_id = Column(Integer, ForeignKey('palabra.id'))
    orden=Column(Integer)
    repeticiones=Column(Integer)
    creado_por =  Column(String(20), nullable=False)
    texto = relationship(Texto)
    palabra = relationship(Palabra)
Base.metadata.create_all(RssReaderDb().getEngine())

