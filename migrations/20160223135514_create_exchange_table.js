'use strict';

exports.up = function(knex, Promise) {
  return knex.schema.createTable("exchange", function (table) {
    table.increments();
    table.string("name");
    table.timestamps();
  });
};

exports.down = function(knex, Promise) {
  return knex.schema.dropTable("exchange");
};
