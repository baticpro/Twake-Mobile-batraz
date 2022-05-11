import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twake/models/globals/globals.dart';
import 'package:twake/repositories/companies_repository.dart';
import 'package:twake/services/service_bundle.dart';

import 'companies_state.dart';

export 'companies_state.dart';

class CompaniesCubit extends Cubit<CompaniesState> {
  late final CompaniesRepository _repository;

  CompaniesCubit({CompaniesRepository? repository})
      : super(CompaniesInitial()) {
    if (repository == null) {
      repository = CompaniesRepository();
    }
    _repository = repository;
  }

  Future<bool> fetch() async {
    final streamCompanies = _repository.fetch();

    Company? selected;
    await for (var companies in streamCompanies) {
      if (companies.isNotEmpty) {
        if (Globals.instance.companyId != null) {
          try {
            selected =
                companies.firstWhere((c) => c.id == Globals.instance.companyId);
          } catch (e) {
            Logger().log(Level.info, 'User don\'t have any company yet');
            return false;
          }
        } else {
          selected = companies.first;
          Globals.instance.companyIdSet = selected.id;
        }
      }

      if (selected != null) {
        emit(CompaniesLoadSuccess(companies: companies, selected: selected));
      }
    }
    return selected != null;
  }

  void selectCompany({required String companyId}) {
    Globals.instance.companyIdSet = companyId;

    if (state is! CompaniesLoadSuccess) return;

    final companies = (state as CompaniesLoadSuccess).companies;

    final selected = companies.firstWhere((c) => c.id == companyId);

    SynchronizationService.instance.subscribeForChannels(
      companyId: companyId,
      workspaceId: 'direct',
    );

    emit(CompaniesLoadSuccess(companies: companies, selected: selected));
  }

  void selectWorkspace({required String workspaceId}) {
    if (state is! CompaniesLoadSuccess) return;

    final selected = (state as CompaniesLoadSuccess).selected;

    selected.selectedWorkspace = workspaceId;

    _repository.saveOne(company: selected);
  }

  Company? getSelectedCompany() {
    if (state is CompaniesLoadSuccess) {
      return (state as CompaniesLoadSuccess).selected;
    }
    return null;
  }
}
