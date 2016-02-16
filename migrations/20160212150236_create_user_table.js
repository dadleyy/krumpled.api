"use strict";

exports.up = function(knex, Promise) {
  return knex.schema.createTable("user", function (table) {
    table.increments();
    table.string("full_name");
    table.string("email");
    table.string("username");
    table.string("password");
    table.timestamps();
  });
};

exports.down = function(knex, Promise) {
  return knex.schema.dropTable("user");
};
