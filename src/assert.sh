#!/bin/bash

function assert_equals() {
  local expected="$1"
  local actual="$2"
  local label="${3:-$(helper::normalize_test_function_name "${FUNCNAME[1]}")}"

  if [[ "$expected" != "$actual" ]]; then
    state::add_assertions_failed
    console_results::print_failed_test "${label}" "${expected}" "but got" "${actual}"
    return
  fi

  state::add_assertions_passed
}

function assert_empty() {
  local expected="$1"
  local label="${2:-$(helper::normalize_test_function_name "${FUNCNAME[1]}")}"

  if [[ "$expected" != "" ]]; then
    state::add_assertions_failed
    console_results::print_failed_test "${label}" "to be empty" "but got" "${expected}"
    return
  fi

  state::add_assertions_passed
}

function assert_not_empty() {
  local expected="$1"
  local label="${2:-$(helper::normalize_test_function_name "${FUNCNAME[1]}")}"

  if [[ "$expected" == "" ]]; then
    state::add_assertions_failed
    console_results::print_failed_test "${label}" "to not be empty" "but got" "${expected}"
    return
  fi

  state::add_assertions_passed
}

function assert_not_equals() {
  local expected="$1"
  local actual="$2"
  local label="${3:-$(helper::normalize_test_function_name "${FUNCNAME[1]}")}"

  if [[ "$expected" == "$actual" ]]; then
    state::add_assertions_failed
    console_results::print_failed_test "${label}" "${expected}" "but got" "${actual}"
    return
  fi

  state::add_assertions_passed
}

function assert_contains() {
  local expected="$1"
  local actual="$2"
  local label="${3:-$(helper::normalize_test_function_name "${FUNCNAME[1]}")}"

  if ! [[ $actual == *"$expected"* ]]; then
    state::add_assertions_failed
    console_results::print_failed_test "${label}" "${actual}" "to contain" "${expected}"
    return
  fi

  state::add_assertions_passed
}

function assert_not_contains() {
  local expected="$1"
  local actual="$2"
  local label="${3:-$(helper::normalize_test_function_name "${FUNCNAME[1]}")}"

  if [[ $actual == *"$expected"* ]]; then
    state::add_assertions_failed
    console_results::print_failed_test "${label}" "${actual}" "to not contain" "${expected}"
    return
  fi

  state::add_assertions_passed
}

function assert_matches() {
  local expected="$1"
  local actual="$2"
  local label="${3:-$(helper::normalize_test_function_name "${FUNCNAME[1]}")}"

  if ! [[ $actual =~ $expected ]]; then
    state::add_assertions_failed
    console_results::print_failed_test "${label}" "${actual}" "to match" "${expected}"
    return
  fi

  state::add_assertions_passed
}

function assert_not_matches() {
  local expected="$1"
  local actual="$2"
  local label="${3:-$(helper::normalize_test_function_name "${FUNCNAME[1]}")}"

  if [[ $actual =~ $expected ]]; then
    state::add_assertions_failed
    console_results::print_failed_test "${label}" "${actual}" "to not match" "${expected}"
    return
  fi

  state::add_assertions_passed
}

function assert_exit_code() {
  local actual_exit_code=${3-"$?"}
  local expected_exit_code="$1"
  local label="${2:-$(helper::normalize_test_function_name "${FUNCNAME[1]}")}"

  if [[ "$actual_exit_code" -ne "$expected_exit_code" ]]; then
    state::add_assertions_failed
    console_results::print_failed_test "${label}" "${actual_exit_code}" "to be" "${expected_exit_code}"
    return
  fi

  state::add_assertions_passed
}

function assert_successful_code() {
  local actual_exit_code=${3-"$?"}
  local expected_exit_code=0
  local label="${2:-$(helper::normalize_test_function_name "${FUNCNAME[1]}")}"

  if [[ "$actual_exit_code" -ne "$expected_exit_code" ]]; then
    state::add_assertions_failed
    console_results::print_failed_test "${label}" "${actual_exit_code}" "to be exactly" "${expected_exit_code}"
    return
  fi

  state::add_assertions_passed
}

function assert_general_error() {
  local actual_exit_code=${3-"$?"}
  local expected_exit_code=1
  local label="${2:-$(helper::normalize_test_function_name "${FUNCNAME[1]}")}"

  if [[ $actual_exit_code -ne "$expected_exit_code" ]]; then
    state::add_assertions_failed
    console_results::print_failed_test "${label}" "${actual_exit_code}" "to be exactly" "${expected_exit_code}"
    return
  fi

  state::add_assertions_passed
}

function assert_command_not_found() {
  local actual_exit_code=${3-"$?"}
  local expected_exit_code=127
  local label="${2:-$(helper::normalize_test_function_name "${FUNCNAME[1]}")}"

  if [[ $actual_exit_code -ne "$expected_exit_code" ]]; then
    state::add_assertions_failed
    console_results::print_failed_test "${label}" "${actual_exit_code}" "to be exactly" "${expected_exit_code}"
    return
  fi

  state::add_assertions_passed
}

function assert_string_starts_with() {
  local expected="$1"
  local actual="$2"
  local label="${3:-$(helper::normalize_test_function_name "${FUNCNAME[1]}")}"

  if ! [[ $actual =~ ^"$expected"* ]]; then
    state::add_assertions_failed
    console_results::print_failed_test "${label}" "${actual}" "to start with" "${expected}"
    return
  fi

  state::add_assertions_passed
}

function assert_string_not_starts_with() {
  local expected="$1"
  local actual="$2"
  local label="${3:-$(helper::normalize_test_function_name "${FUNCNAME[1]}")}"

  if [[ $actual =~ ^"$expected"* ]]; then
    state::add_assertions_failed
    console_results::print_failed_test "${label}" "${actual}" "to not start with" "${expected}"
    return
  fi

  state::add_assertions_passed
}
